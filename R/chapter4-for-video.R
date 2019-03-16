source(here::here("R/setup.R"))
load(here::here("datasets/sample_tidied_framingham.rda"))

# Video 1 -----------------------------------------------------------------

tidy_glm <- function(predictors) {
    model_formula <- as.formula(glue("got_cvd ~ {predictors}"))
    glmer(model_formula, family = binomial, data = sample_tidied_framingham) %>%
        tidy(conf.int = TRUE, exponentiate = TRUE) %>%
        select(effect, term, estimate, conf.low, conf.high)
}

predictors <- c("total_cholesterol_scaled", "body_mass_index_scaled")
predictors_with_random <- paste(predictors, "(1 | subject_id)", sep = " + ")
predictors_with_covars <- paste(predictors, "sex", "(1 | subject_id)", sep = " + ")

unadjusted_models_list <- map(predictors_with_random, tidy_glm)
adjusted_models_list <- map(predictors_with_covars, tidy_glm)

# For video
unadjusted_models_list

map(unadjusted_models_list, ~mutate(.x, model = "Unadjusted"))

map(unadjusted_models_list, ~mutate(.x, model = "Unadjusted")) %>%
    bind_rows()

bind_rows(map(unadjusted_models_list, ~ mutate(.x, model = "Unadjusted")),
          map(adjusted_models_list, ~ mutate(.x, model = "Adjusted"))) %>%
    mutate(outcome = "got_cvd")

# Video 2, compare plot vs table ------------------------------------------

extract_results <- function(x) {
    glmer(x$model_formula, data = sample_tidied_framingham,
          family = binomial, nAGQ = 0) %>%
        tidy(conf.int = TRUE, exponentiate = TRUE) %>%
        mutate(predictor = x$predictor, outcome = "got_cvd")
}

individual_models <- map(c("body_mass_index_scaled", "systolic_blood_pressure_scaled",
                           "fasting_blood_glucose_scaled"),
    ~ list(model_formula = as.formula(glue("got_cvd ~ {.x} + (1 | subject_id)")),
           predictor = .x)) %>%
    map_dfr(extract_results)

models_plot <- individual_models %>%
    filter(predictor == term) %>%
    mutate(predictor = str_remove(predictor, "_scaled$")) %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.15) +
    geom_vline(xintercept = 1, linetype = "dotted")

ggsave(here::here("datasets/ch4-v2-models.png"), models_plot,
       height = 2.5, width = 8, dpi = 90)

individual_models %>%
    filter(predictor == term) %>%
    mutate(predictor = str_remove(predictor, "_scaled$")) %>%
    mutate_if(is.numeric, round, digits = 1) %>%
    mutate(estimate_ci = glue("{estimate} ({conf.low}, {conf.high})")) %>%
    select(Predictor = predictor, `Estimate (95% CI)` = estimate_ci) %>%
    knitr::kable()

# Video 2, creating plot --------------------------------------------------

# Not for video. individual_models from previous section
models <- individual_models %>%
    filter(predictor == term,
           predictor != "body_mass_index_scaled") %>%
    mutate(predictor = str_remove(predictor, "_scaled$"))

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
    geom_point(size = 2) +
    geom_errorbarh(height = 0.1) +
    geom_vline(xintercept = 1, linetype = "dashed") +
    theme_bw()

ggsave(here::here("datasets/ch4-v2-estimate-ci-nicer.png"), estimate_ci_plot_nicer,
       height = 2.5, width = 8, dpi = 90)

# Video 2, adjusted and unadjusted ----------------------------------------

adj_individual_models <- map(c("body_mass_index_scaled", "systolic_blood_pressure_scaled",
                           "fasting_blood_glucose_scaled"),
    ~ list(model_formula = as.formula(glue("got_cvd ~ {.x} + sex + body_mass_index_scaled + (1 | subject_id)")),
           predictor = .x)) %>%
    map_dfr(extract_results)

# Not for video
models <-
    bind_rows(
        individual_models %>% mutate(model = "unadjusted"),
        adj_individual_models %>% mutate(model = "adjusted")
    ) %>%
    filter(predictor == term,
           predictor != "body_mass_index_scaled") %>%
    mutate(predictor = str_remove(predictor, "_scaled$"))

# For video
unadjusted_adjusted <- models %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed") +
    facet_grid(rows = vars(model))

unadjusted_adjusted <- unadjusted_adjusted +
    coord_cartesian(ylim = c(0.7, 2.3), xlim = c(0.5, 4.5), expand = FALSE)

ggsave(here::here("datasets/ch4-v2-unadjusted-adjusted.png"), unadjusted_adjusted,
       height = 2.5, width = 8, dpi = 90)

# Video 3, characteristics table ------------------------------------------

tidied_framingham %>%
    outline_table()

tidied_framingham %>%
    outline_table() %>%
    add_rows("education_combined",
             stat = stat_nPct)

tidied_framingham %>%
    outline_table() %>%
    add_rows("education_combined",
             stat = stat_nPct) %>%
    add_rows("body_mass_index",
             stat = stat_meanSD) %>%
    add_rows(c("participant_age", "heart_rate"),
             stat = stat_medianIQR)

basic_char_table <- tidied_framingham %>%
    outline_table() %>%
    add_rows("education_combined", stat = stat_nPct) %>%
    add_rows("body_mass_index", stat = stat_meanSD) %>%
    add_rows(c("participant_age", "heart_rate"),
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

