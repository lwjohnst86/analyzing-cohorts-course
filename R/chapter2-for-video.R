source(here::here("R/setup.R"))
load(here::here("datasets/framingham_tidier.rda"))

# Video 1 -----------------------------------------------------------------

p <-
    ggplot(tidier_framingham,
       aes(x = body_mass_index)) +
    geom_histogram()
ggsave(here::here("datasets/ch2-v1-histogram.png"), p, height = 4, width = 4, dpi = 90)

wide_form <- head(tidier_framingham, 4) %>%
    select(subject_id, body_mass_index,
           total_cholesterol)
wide_form

long_form <- wide_form %>%
    gather(variable, value, -subject_id)
long_form

long_form <- diet %>%
    select(id, weight, energy_intake = energy) %>%
    gather(variable, value, -id)
p <- long_form %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_wrap(vars(variable), scale = "free", nrow = 1)
ggsave(here::here("datasets/ch2-v1-two-histograms.png"), p, dpi = 72, width = 7.5, height = 4)

p <- diet %>%
    mutate(chd = as.character(chd)) %>%
    ggplot(aes(x = chd, y = weight,
               colour = chd)) +
    geom_boxplot()
ggsave(here::here("datasets/ch2-v1-boxplot.png"), p, dpi = 90, width = 4, height = 4, device = "png")

# Video 2 -----------------------------------------------------------------

plot_discretising <- diet %>%
    mutate(BMI = weight / ((height / 100) ^ 2)) %>%
    ggplot(aes(x = BMI)) +
    geom_histogram(colour = "black", fill = color_theme[7], bins = 40) +
    geom_vline(xintercept = c(20, 25, 30), size = 1, linetype = "dashed") +
    xlab("Body mass index")
ggsave(here::here("datasets/plot-discretising.png"), dpi = 100)

count(diet, job)

reduced_job <- diet %>%
    mutate(bank_worker = case_when(
        job == "Bank worker" ~ "Yes",
        job != "Bank worker" ~ "No",
        TRUE ~ NA_character_
    ))
count(reduced_job, bank_worker)

library(forcats)
diet %>%
    mutate(job = fct_recode(
        job, "Banker" = "Bank worker"
    )) %>%
    count(job)

# Video 3 -----------------------------------------------------------------

# summary(diet)

diet <- as_tibble(diet)
invert <- function(x) 1 / x
transformed <- diet %>%
    select(weight, height) %>%
    mutate_at(vars(weight, height),
              funs(scale, log, invert))

## Variable names
transformed %>%
    select(matches("weight|height")) %>%
    names()

## Histogram and density

invert <- function(x) 1 / x
transformed <- diet %>%
    mutate_at(vars(weight, height),
              funs(scale, log, invert))

ggplot(transformed, aes(x = weight, # And another for each transform
                        y = stat(density))) +
    geom_histogram(colour = "black", fill = "lightyellow", size = 0.25) +
    geom_density()

histo_density <- function(.data, x) {
    xvar <- enquo(x)
    ggplot(transformed, aes(x = !!xvar, y = stat(density))) +
        geom_histogram(colour = "black", fill = color_theme[7], size = 0.25) +
        geom_density() +
        theme_gray(base_size = 18)
}

plot_transform_weight <- histo_density(transformed, weight) +
    histo_density(transformed, weight_scale) + ylab("") +
    histo_density(transformed, weight_log) +
    histo_density(transformed, weight_invert) + ylab("")
ggsave(here::here("datasets/ch2-v3-transform-weight.png"), width = 7, height = 6)
