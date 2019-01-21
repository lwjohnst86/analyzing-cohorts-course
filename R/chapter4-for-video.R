source(here::here("R/setup.R"))


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

model_energy <- glm(chd ~ energy, data = diet, family = binomial) %>%
    tidy(conf.int = TRUE, exponentiate = TRUE)

model_fibre <- glm(chd ~ fibre, data = diet, family = binomial) %>%
    tidy(conf.int = TRUE, exponentiate = TRUE)

models <- bind_rows(
    model_energy %>% mutate(predictor = "energy"),
    model_fibre %>% mutate(predictor = "fibre")
)

estimate_ci_plot <- models %>%
    filter(predictor == term) %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed")

ggsave(here::here("datasets/ch4-v2-estimate-ci.png"), estimate_ci_plot,
       height = 5, width = 8, dpi = 100)
