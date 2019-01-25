source(here::here("R/setup.R"))

# Video 1 -----------------------------------------------------------------

tidy_glm <- function(predictors) {
    model_formula <- as.formula(glue("chd ~ {predictors}"))
    glm(model_formula, family = binomial, data = diet) %>%
        tidy(conf.int = TRUE, exponentiate = TRUE)
}

predictors <- c("energy", "fibre")
predictors_with_covars <- paste(predictors, "weight", sep = " + ")

unadjusted_models_list <- map(predictors, tidy_glm)
adjusted_models_list <- map(predictors_with_covars, tidy_glm)

# For video

unadjusted_models_list

models_df <- bind_rows(
        map(unadjusted_models_list, ~ .x %>% mutate(model = "Unadjusted")),
        map(adjusted_models_list, ~ .x %>% mutate(model = "Adjusted"))
    ) %>%
    mutate(outcome = "chd")
models_df

# Video 2, compare plot vs table ------------------------------------------

extract_results <- function(x) {
    glm(x$model_formula, data = diet, family = binomial) %>%
        tidy(conf.int = TRUE, exponentiate = TRUE) %>%
        mutate(predictor = x$predictor, outcome = "chd")
}

individual_models <- map(c("energy", "fibre", "fat"),
    ~ list(model_formula = as.formula(glue("chd ~ {.x}")),
           predictor = .x)) %>%
    map_dfr(extract_results)

models_plot <- individual_models %>%
    filter(predictor == term) %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dotted")

ggsave(here::here("datasets/ch4-v2-models.png"), models_plot,
       height = 2.5, width = 8, dpi = 90)

individual_models %>%
    filter(predictor == term) %>%
    mutate_if(is.numeric, round, digits = 1) %>%
    mutate(estimate_ci = glue("{estimate} ({conf.low}, {conf.high})")) %>%
    select(Predictor = predictor, `Estimate (95% CI)` = estimate_ci) %>%
    knitr::kable()

# Video 2, creating plot --------------------------------------------------

# Not for video
model_energy <- glm(chd ~ energy, data = diet, family = binomial) %>%
    tidy(conf.int = TRUE, exponentiate = TRUE)
model_fibre <- glm(chd ~ fibre, data = diet, family = binomial) %>%
    tidy(conf.int = TRUE, exponentiate = TRUE)
models <-
    bind_rows(
        model_energy %>% mutate(predictor = "energy"),
        model_fibre %>% mutate(predictor = "fibre")
    ) %>%
    filter(predictor == term)

# For video
estimate_ci_plot_basic <- models %>%
    # filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh() +
    geom_vline(xintercept = 1)

ggsave(here::here("datasets/ch4-v2-estimate-ci-basic.png"), estimate_ci_plot_basic,
       height = 2.5, width = 8, dpi = 90)

estimate_ci_plot_nicer <- models %>%
    # filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed")

ggsave(here::here("datasets/ch4-v2-estimate-ci-nicer.png"), estimate_ci_plot_nicer,
       height = 2.5, width = 8, dpi = 90)

# Video 2, adjusted and unadjusted ----------------------------------------

tidied_glm <- function(predictors) {
    Formula <- as.formula(glue("chd ~ {predictors}"))
    glm(Formula, data = diet, family = binomial) %>%
        tidy(conf.int = TRUE, exponentiate = TRUE)
}

# Not for video
model_energy <- tidied_glm("energy")
model_fibre <- tidied_glm("fibre")
adj_model_energy <- tidied_glm("energy + weight")
adj_model_fibre <- tidied_glm("fibre + weight")

models <-
    bind_rows(
        model_energy %>% mutate(predictor = "energy", model = "unadjusted"),
        model_fibre %>% mutate(predictor = "fibre", model = "unadjusted"),
        adj_model_energy %>% mutate(predictor = "energy", model = "adjusted"),
        adj_model_fibre %>% mutate(predictor = "fibre", model = "adjusted")
    ) %>%
    filter(predictor == term)

# For video
unadjusted_adjusted <- models %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed") +
    facet_grid(rows = vars(model))

unadjusted_adjusted <- unadjusted_adjusted +
    coord_cartesian(ylim = c(0., 2.1), expand = FALSE)

ggsave(here::here("datasets/ch4-v2-unadjusted-adjusted.png"), unadjusted_adjusted,
       height = 2.5, width = 8, dpi = 90)


# Video 2, interaction plotting -------------------------------------------

# https://cran.r-project.org/web/packages/ggeffects/vignettes/marginaleffects.html

# Video 3, characteristics table ------------------------------------------

diet %>%
    outline_table()

diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct)

diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct) %>%
    add_rows("fibre", stat = stat_meanSD) %>%
    add_rows(c("energy", "weight"),
             stat = stat_medianIQR)

basic_char_table <- diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct) %>%
    add_rows("fibre", stat = stat_meanSD) %>%
    add_rows(c("energy", "weight"),
             stat = stat_medianIQR) %>%
    renaming("header", c("Characteristics", "Values"))
basic_char_table

build_table(basic_char_table)


# Video 3, wrangle model to table -----------------------------------------

# Not for video
tidied_glm <- function(predictors) {
    Formula <- as.formula(glue("chd ~ {predictors}"))
    glm(Formula, data = diet, family = binomial) %>%
        tidy(conf.int = TRUE, exponentiate = TRUE)
}

# Not for video
model_energy <- tidied_glm("energy")
model_fibre <- tidied_glm("fibre")
adj_model_energy <- tidied_glm("energy + weight")
adj_model_fibre <- tidied_glm("fibre + weight")

# Not for video
models <-
    bind_rows(
        model_energy %>% mutate(predictor = "energy", model = "unadjusted"),
        model_fibre %>% mutate(predictor = "fibre", model = "unadjusted"),
        adj_model_energy %>% mutate(predictor = "energy", model = "adjusted"),
        adj_model_fibre %>% mutate(predictor = "fibre", model = "adjusted")
    ) %>%
    filter(predictor == term)

# Show how we want it to look
models %>%
    mutate_at(vars(estimate, std.error), round, digits = 2) %>%
    mutate(estimate_se = glue("{estimate} ({std.error} SE)"),
           predictors = str_to_title(predictor)) %>%
    select(predictors, model, estimate_se) %>%
    spread(model, estimate_se) %>%
    rename_all(str_to_title) %>%
    select(Predictors, Unadjusted, Adjusted) %>%
    knitr::kable()

# Short highlighting of glue
x <- 3
y <- 5
glue("{x} ({y}%)")

models %>%
    select(model, predictor, estimate, std.error) %>%
    mutate_at(vars(estimate, std.error), round, digits = 2) %>%
    mutate(estimate_se = glue("{estimate} ({std.error} SE)"))

models %>%
    select(model, predictor, estimate, std.error) %>%
    mutate_at(vars(estimate, std.error), round, digits = 2) %>%
    mutate(estimate_se = glue("{estimate} ({std.error} SE)")) %>%
    select(predictor, model, estimate_se) %>%
    spread(model, estimate_se)

