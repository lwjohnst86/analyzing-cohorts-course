source(here::here("R/setup.R"))

# Video 2 -----------------------------------------------------------------

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

# inspired by https://blog.revolutionanalytics.com/2013/07/a-great-example-of-simpsons-paradox.html
tribble(
    ~time, ~median_income, ~job_type,
    0, 6.5, 1,
    0, 6.25, 1,
    0, 6, 1,
    1, 6.5, 1,
    1, 6.75, 1,
    1, 6.25, 1,
    1, 6, 1,
    1, 6.1, 1,
    0, 5.5, 2,
    0, 5.25, 2,
    0, 5, 2,
    0, 5.3, 2,
    0, 5.4, 2,
    1, 5, 2,
    1, 4.75, 2,
    1, 4.9, 2
) %>%
    mutate(median_income = median_income * 10) %>%
    ggplot(aes(x = time, y = median_income)) +
    geom_smooth(method = "lm", se = FALSE, colour = "grey40") +
    geom_smooth(aes(group = job_type), method = "lm", se = FALSE, colour = "grey40") +
    geom_point(colour = color_theme[6], size = 4)

tribble(
    ~Treatment, ~KidneyStoneSize, ~SuccessCases, ~TotalCases,
    "A", "Small", 81, 87,
    "A", "Large", 192, 263,
    "B", "Small", 234, 270,
    "B", "Large", 55, 80
) %>%
    group_by(Treatment) %>%
    mutate(Total)


dag_example <- grViz(
    "digraph {
    graph [rankdir = LR]
    Node1 -> Node2 [dir = backward, xlabel = 'Edge ']
    Node1 -> Node3 [dir = forward, label = '     Edge']
    Node2 -> Node4 [label = 'Edge']
    }"
)

grviz_to_png(dag_example,
             here::here("datasets/ch3-v2-dag-example.png"),
             width = 1500)

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
