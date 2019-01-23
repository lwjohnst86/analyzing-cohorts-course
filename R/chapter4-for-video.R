source(here::here("R/setup.R"))

# Video 1 -----------------------------------------------------------------


# **Run (simple) models for each predictor**:
#
# ```{r}
# model_energy <- glm(chd ~ energy, data = diet, family = binomial) %>%
#     tidy(conf.int = TRUE, exponentiate = TRUE)
#
# model_fibre <- glm(chd ~ fibre, data = diet, family = binomial) %>%
#     tidy(conf.int = TRUE, exponentiate = TRUE)
# ```
#
# **Combine models, keep predictor results**:
#
# ```{r}
# models <-
#     bind_rows(
#         model_energy %>% mutate(predictor = "energy"),
#         model_fibre %>% mutate(predictor = "fibre")
#     ) %>%
#     filter(predictor == term)
# ```

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
       height = 4, width = 8, dpi = 100)

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
       height = 5, width = 8, dpi = 100)

estimate_ci_plot_nicer <- models %>%
    # filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed")

ggsave(here::here("datasets/ch4-v2-estimate-ci-nicer.png"), estimate_ci_plot_nicer,
       height = 5, width = 8, dpi = 100)

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

ggsave(here::here("datasets/ch4-v2-unadjusted-adjusted.png"), unadjusted_adjusted,
       height = 5, width = 8, dpi = 100)
