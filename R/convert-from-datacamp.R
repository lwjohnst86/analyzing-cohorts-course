
# Loading library and setting up package ----------------------------------

library(fs)
library(stringr)
library(readr)
library(dplyr)
library(tidyr)
library(usethis)
library(here)
library(purrr)
library(glue)
# library(git2r)
options(usethis.quiet = TRUE)

# For accidental sourcing... -_-
stop()

# Checking if project is under git and if changes are not committed
if (git2r::in_repository())
    stop("Please make that the files are under Git version control.")
if (!is.null(git2r::status()$unstaged))
    stop("Please make sure to commit changes before running.")

# Listing all files -------------------------------------------------------

all_files <- dir_ls(here(), recursive = TRUE, type = "file", all = TRUE)
proj_name <- str_subset(all_files, "\\.Rproj$")

# Create as package -------------------------------------------------------

create_package(path_dir(proj_name))
use_data_raw()

# Set dependencies --------------------------------------------------------

dependencies <- str_subset(all_files, "requirements.R") %>%
    read_lines() %>%
    str_subset("install") %>%
    str_extract('\".*\"') %>%
    str_remove_all('"') %>%
    str_remove(',.*$')
map(dependencies, use_package)
file_delete("requirements.R")

# Fixing and moving chapter files -----------------------------------------

chapters <- str_subset(all_files, "chapter.\\.md")

tibble(Lines = read_lines(chapters[1])) %>%
    mutate(
        Lines = if_else(
            str_detect(Lines, "^`@instructions`.*$"),
            "**Instructions**:",
            Lines
        ),
        LessonTag = Lines %>%
            str_extract("## .*$") %>%
            str_remove("## ") %>%
            str_remove_all(",|\\?|\\!|\\.|\\:|\\;") %>%
            str_to_lower() %>%
            str_replace_all(" ", "-"),
        ExerciseType = str_extract(Lines, "^type: .*$") %>%
            str_remove("type: ") %>%
            str_trim(),
        ExerciseSections = str_extract(Lines, "`\\@.*`.*$") %>%
            str_remove_all("(^`)|(\\@)|(`$)") %>%
            str_trim()
    ) %>%
    fill(LessonTag) %>%
    group_by(LessonTag) %>%
    fill(ExerciseType, ExerciseSections) %>%
    mutate(
        LinesModified = case_when(
            !str_detect(Lines, "```\\{r") ~ Lines,
            ExerciseSections == "pre_exercise_code" ~ as.character(glue("```{{r {LessonTag}-setup}}")),
            ExerciseSections == "sample_code" ~ as.character(
                glue(
                    "```{{r {LessonTag}, exercise=TRUE, exercise.setup='{LessonTag}-setup'}}"
                )
            ),
            ExerciseSections == "sample_code" ~ as.character(glue("```{{r {LessonTag}-solution}}")),
            TRUE ~ Lines
        ),
        LinesModified = if_else(
            str_detect(LinesModified, "\\@hint"),
            as.character(glue('<div id="{LessonTag}-hint">')),
            LinesModified
        )
    ) %>%
    # group_by(LessonTag, ExerciseType, ExerciseSections) %>%
    mutate(LinesModified = if_else(
        !is.na(ExerciseSections) & ExerciseSections == "hint" & lead(ExerciseSections) != "hint",
        str_c(LinesModified, "</div>"),
        LinesModified
        )
    ) %>%
    ungroup() %>%
    mutate(
        LinesModified = LinesModified %>%
            str_remove("^(key|xp|lang|skills):.*$") %>%
            str_remove("^type: .*$") %>%
            str_remove("^`+yaml.*$") %>%
            str_remove("^`\\@.*`.*$")
    ) %>%
    filter(!(str_detect(LinesModified, "^`+") & is.na(ExerciseSections)))  %>%
    View()
    # pull(LinesModified)

new_chapter_path <- here("inst/tutorials", path_file(chapters)) %>%
    str_replace("\\.md", ".Rmd")

file_move(chapters, new_chapter_path)

# Update datasets into data -----------------------------------------------

datasets <- all_files %>%
    str_subset("\\.(rda|rds)$")
file_delete(datasets)

wrangling_file <- str_subset(all_files, "wrangle\\.R$")
wrangling_file %>%
    read_lines() %>%
    str_replace("^save*?\\((.*), file = .*$", "use_data(\\1, overwrite = TRUE)") %>%
    write_lines(path = wrangling_file)
file_move(wrangling_file, here("data-raw"))
source(here("data-raw/wrangle.R"))

# TODO: Export all datasets? Or is that done automatically?

# Move images -------------------------------------------------------------

images <- str_subset(all_files, "datasets/.*\\.png$")
file_move(images, here("inst/tutorials/images"))

# Adding other package additions ------------------------------------------

use_build_ignore("slides")
use_tidy_versions()
use_github_links()
use_mit_license()
use_blank_slate()
