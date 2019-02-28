source(here::here("R/setup.R"))
load(here::here("datasets/tidied_framingham.rda"))

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
    Sex -> {Height ColonCancer}
    Sex -> MeatIntake -> ColonCancer
}")

adjustmentSets(possible_confounders, exposure = "Height", outcome = "ColonCancer")

png(here::here("datasets/ch3-v2-dagitty.png"),
    width = 800, height = 450, pointsize = 18)
plot(graphLayout(possible_confounders))
dev.off()

# Video 2, AIC ------------------------------------------------------------

cleaned_diet <- diet %>%
    mutate(bmi = weight / (height / 100)^2) %>%
    select(energy, bmi, fat, fibre, chd) %>%
    na.omit()

full_model <- glm(chd ~ ., data = cleaned_diet,
                  family = binomial, na.action = "na.fail")

model_selection <- dredge(full_model, rank = "AIC", subset = "fibre")

head(model_selection, 4)

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

model <- glm(chd ~ weight + energy, data = diet, family = binomial)
summary(model)

tidy(model)

tidy(model, conf.int = TRUE)


# Video 4, backtransforming estimates -------------------------------------

model <- glm(chd ~ weight + fibre + energy,
             data = diet, family = binomial)

tidied_model <- tidy(model, conf.int = TRUE) %>%
    select(term, estimate, conf.low, conf.high)
tidied_model

tidied_model %>%
    mutate_at(vars(-term), exp)
