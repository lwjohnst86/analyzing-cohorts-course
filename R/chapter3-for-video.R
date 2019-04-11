source(here::here("R/setup.R"))
load(here::here("datasets/tidied_framingham.rda"))
load(here::here("datasets/sample_tidied_framingham.rda"))

# Video 2, confounder -----------------------------------------------------

grviz_to_png <- function(graph_viz, filename, width = NULL, height = NULL) {
    graph_viz %>%
        export_svg() %>%
        charToRaw() %>%
        rsvg::rsvg_png(file = filename, width = width, height = height)
}

confounding_dag <- grViz("
digraph {
    node [style = filled fillcolor = none]
    {
        rank = same
        Exposure [fillcolor = 'LightBlue']
        Outcome [fillcolor = 'OrangeRed']
    }
    Exposure -> Outcome
    Confounder -> {Exposure Outcome}
}")

grviz_to_png(confounding_dag,
             here::here("datasets/ch3-v2-classic-confounder.png"),
             width = 1500)


# Video 2, Simpon's paradox -----------------------------------------------

kidney_stones <- tribble(
    ~Treatment, ~KidneyStoneSize, ~SuccessCases, ~TotalCases,
    "A", "Small", 81, 87,
    "A", "Large", 192, 263,
    "B", "Small", 234, 270,
    "B", "Large", 55, 80
)

kidney_stones %>%
    group_by(Treatment) %>%
    summarize(Success = round((sum(SuccessCases) / sum(TotalCases)) * 100, 0),
              Success = glue::glue("{Success}%")) %>%
    knitr::kable()

kidney_stones %>%
    group_by(Treatment, KidneyStoneSize) %>%
    rename(`Kidney stone size` = KidneyStoneSize) %>%
    summarize(Success = round((sum(SuccessCases) / sum(TotalCases)) * 100, 0),
              Success = glue::glue("{Success}%")) %>%
    knitr::kable()

kidney_stones %>%
    rename(`Kidney stone size` = KidneyStoneSize,
           Successes = SuccessCases, `Total cases` = TotalCases) %>%
    knitr::kable()

# Video 2, show dagitty ---------------------------------------------------

possible_confounders <- dagitty("dag {
    Height -> ColonCancer
}")

png(here::here("datasets/ch3-v2-dagitty-1.png"),
    width = 300, height = 175, pointsize = 18)
plot(graphLayout(possible_confounders))
dev.off()

possible_confounders <- dagitty("dag {
    Height -> ColonCancer
    Sex -> {Height ColonCancer}
}")

adjustmentSets(possible_confounders, exposure = "Height", outcome = "ColonCancer")

png(here::here("datasets/ch3-v2-dagitty-2.png"),
    width = 300, height = 175, pointsize = 18)
plot(graphLayout(possible_confounders))
dev.off()

# Video 2, AIC ------------------------------------------------------------

tidied_fh2 <- sample_tidied_framingham %>%
    select(subject_id, body_mass_index_scaled, total_cholesterol_scaled,
           participant_age, got_cvd, currently_smokes, education_combined,
           sex) %>%
    mutate(currently_smokes = if_else(currently_smokes == 0, "No", "Yes"),
           subject_id = as.character(subject_id),
           participant_age = as.numeric(scale(participant_age, scale = FALSE) / 10)) %>%
    na.omit()

glmer_formula <- as.formula(
    got_cvd ~ body_mass_index_scaled + total_cholesterol_scaled +
        participant_age + currently_smokes + education_combined +
        sex + (1 | subject_id)
)
full_model <- glmer(glmer_formula, data = tidied_fh2, family = binomial,
                    na.action = "na.fail", nAGQ = 0)

summary(full_model)

model_selection <- dredge(full_model, rank = "AIC",
                          subset = "total_cholesterol_scaled")

head(model_selection, 5)

# Video 3, interaction form -----------------------------------------------

model_with_interaction <- glmer(
    got_cvd ~ body_mass_index_scaled * sex + (1 | subject_id),
    data = tidied_framingham, family = binomial)
summary(model_with_interaction)

# Video 3, interaction form -----------------------------------------------

model_no_interaction <- glmer(
    got_cvd ~ body_mass_index_scaled + sex + (1 | subject_id),
    data = tidied_framingham, family = binomial)
model_with_interaction <- glmer(
    got_cvd ~ body_mass_index_scaled * sex + (1 | subject_id),
    data = tidied_framingham, family = binomial)
model.sel(model_no_interaction, model_with_interaction, rank = "AIC")
as.data.frame(model.sel(model_no_interaction, model_with_interaction, rank = "AIC"))[6:9]

# Video 3, sensitivity analysis -------------------------------------------

no_diabetes_framingham <- tidied_framingham %>%
    filter(diabetes == 0)

glmer(got_cvd ~ body_mass_index_scaled + (1 | subject_id),
      data = tidied_framingham, family = binomial) %>%
    fixef()

glmer(got_cvd ~ body_mass_index_scaled + (1 | subject_id),
      data = no_diabetes_framingham, family = binomial) %>%
    fixef()

# Video 4, tidy function example ------------------------------------------

library(broom.mixed)
library(lme4)
model <- glmer(got_cvd ~ body_mass_index_scaled + sex + (1 | subject_id),
    data = tidied_framingham, family = binomial)

tidy(model)
tidy(model, conf.int = TRUE)

# Video 4, backtransforming and important variables -----------------------

tidied_model <- model %>%
    tidy(exponentiate = TRUE, conf.int = TRUE) %>%
    select(effect, term, estimate, conf.low, conf.high)
tidied_model
