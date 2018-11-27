source(here::here("R/setup.R"))

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

# plot(graphLayout(possible_confounders))

# Video 2, AIC ------------------------------------------------------------

cleaned_diet <- diet %>%
    mutate(bmi = weight / (height / 100)^2) %>%
    select(energy, bmi, fat, fibre, chd) %>%
    na.omit()

full_model <- glm(chd ~ ., data = cleaned_diet,
                  family = binomial, na.action = "na.fail")

model_selection <- dredge(full_model, rank = "AIC", subset = "fibre")

head(model_selection, 4)


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
