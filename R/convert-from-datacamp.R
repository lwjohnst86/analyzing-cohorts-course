
# Loading library and setting up package ----------------------------------

library(fs)
library(stringr)
library(readr)
library(usethis)
library(here)
library(purrr)

all_files <- dir_ls(here(), recursive = TRUE, type = "file", all = TRUE)

create_package(here("../acdc"))
use_data_raw()

# Set dependencies --------------------------------------------------------

dependencies <- str_subset(all_files, "requirements.R") %>%
    read_lines() %>%
    str_subset("install") %>%
    str_extract('\".*\"') %>%
    str_remove_all('"') %>%
    str_remove(',.*$')
map(dependencies, use_package)

# Fixing and moving chapter files -----------------------------------------

chapters <- str_subset(all_files, "chapter.\\.md")

# chapters[1] %>%
#     read_lines() %>%
#     str_remove_all("^(key|xp).*$") %>%
#     str_c(collapse = "NEWLINE") %>%
#     str_replace_all("`@sample_code`(.*)```\\{r\\}", "\\1```{r ch1-FINISH, exercise=TRUE}") %>%
#     str_split("NEWLINE")

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
