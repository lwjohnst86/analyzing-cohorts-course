source(here::here("R/setup.R"))
load(here::here("datasets/framingham_tidier.rda"))
tidier2_framingham <- readRDS(here::here("datasets/tidier2_framingham.Rds"))
transformed_framingham <- readRDS(here::here("datasets/transformed_framingham.Rds"))

# Video 1 histogram -------------------------------------------------------

p <- ggplot(tidier_framingham,
       aes(x = body_mass_index)) +
    geom_histogram()
ggsave(here::here("datasets/ch2-v1-histogram.png"), p,
       height = 4, width = 4, dpi = 90)

# Video 1 multiple vars with gather ---------------------------------------

wide_form <- tidier_framingham %>%
    select(subject_id,
           body_mass_index,
           participant_age)
head(wide_form, 4)

long_form <- wide_form %>%
    head(4) %>%
    gather(variable, value, -subject_id)
long_form

# Video 1 long form and histograms ----------------------------------------

p <- wide_form %>%
    gather(variable, value, -subject_id) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_wrap(vars(variable), scale = "free", nrow = 1)
ggsave(here::here("datasets/ch2-v1-two-histograms.png"), p, dpi = 90,
       width = 7.5, height = 2.75)

# Video 1 visualize exposure and outcome ----------------------------------

p <- tidier_framingham %>%
    mutate(got_cvd = as.character(got_cvd)) %>%
    ggplot(aes(x = got_cvd,
               y = body_mass_index,
               colour = got_cvd)) +
    geom_boxplot()
ggsave(here::here("datasets/ch2-v1-boxplot.png"), p, dpi = 90,
       width = 4, height = 4, device = "png")

# Video 2 discretizing ----------------------------------------------------

plot_discretising <- tidier_framingham %>%
    ggplot(aes(x = body_mass_index)) +
    geom_histogram(colour = "black", fill = "grey80", bins = 40) +
    geom_vline(xintercept = c(20, 25, 30), size = 1, linetype = "dashed")
ggsave(here::here("datasets/ch2-v2-discretising.png"),
       width = 6.5, height = 4.5, dpi = 90)

# For video
tidier_framingham %>%
    ggplot(aes(x = body_mass_index)) +
    geom_histogram(colour = "black",
                   fill = "grey80") +
    geom_vline(xintercept = c(20, 25, 30),
               linetype = "dashed")

# Video 2 tidying discrete variables --------------------------------------

tidier_framingham %>%
    count(cigarettes_per_day)

tidier_framingham <- tidier_framingham %>%
    mutate(cig_packs_per_day = case_when(
        cigarettes_per_day == 0 ~ "None",
        cigarettes_per_day >= 1 &
            cigarettes_per_day <= 20 ~ "Up to one",
        cigarettes_per_day >= 21 &
            cigarettes_per_day <= 40 ~ "One to two",
        cigarettes_per_day > 40 ~ "More than two",
        TRUE ~ NA_character_
    ))
tidier_framingham %>%
    count(cig_packs_per_day)

library(forcats)
tidier_framingham %>%
    mutate(cig_packs_per_day = fct_recode(
        cig_packs_per_day, "More than two" = "One to two"
    )) %>%
    count(cig_packs_per_day)

# Video 3 transforming variables ------------------------------------------

invert <- function(x) 1 / x
transformed <- tidier2_framingham %>%
    mutate_at(vars(body_mass_index, heart_rate),
              funs(scale, log, invert))

## Variable names
transformed %>%
    select(contains("body_mass_index"),
           contains("heart_rate")) %>%
    names()

# Video 3 plotting transformations ----------------------------------------

p <- transformed %>%
    select(contains("heart_rate")) %>%
    gather(transformations, values) %>%
    ggplot(aes(x = values, y = stat(density))) +
    geom_histogram(colour = "black", fill = "grey80", size = 0.25) +
    geom_density() +
    facet_wrap(vars(transformations), scales = "free")

ggsave(here::here("datasets/ch2-v3-transform-hr.png"), p,
       width = 6.5, height = 4, dpi = 90)
