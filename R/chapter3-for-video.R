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
    # geom_smooth(aes(group = job_type), method = "lm", se = FALSE, colour = "grey40") +
    geom_point(colour = color_theme[6], size = 4)



# dag_example <-
grViz("
digraph {
    Node1 -> Node2 [dir = backward, xlabel = 'Edge ']
    Node1 -> Node3 [dir = forward, xlabel = '     Edge']
    Node2 -> Node4 [xlabel = 'Edge  ']
}")

grViz("
digraph {
    node [style = filled fillcolor = none]
    {
        rank = same
        BodyFat [fillcolor = 'LightBlue']
        CVD [fillcolor = 'OrangeRed']
    }
    BodyFat -> CVD
    Sex -> {BodyFat CVD Testosterone}
    Testosterone -> {BodyFat CVD}
}")

grViz("
digraph {
    node [style = filled fillcolor = none]
    {
        rank = same
        BodyFat [fillcolor = 'LightBlue']
        CVD [fillcolor = 'OrangeRed']
    }
    BodyFat -> CVD
    Sex -> {BodyFat CVD Testosterone ExerciseType}
    Testosterone -> {BodyFat CVD}
    ExerciseType -> {BodyFat CVD}
}")

grViz("
digraph {
    node [style = filled fillcolor = none]
    {
        rank = same
        BodyFat [fillcolor = 'LightBlue']
        CVD [fillcolor = 'OrangeRed']
    }
    BodyFat -> CVD
    Sex -> {BodyFat CVD Testosterone ExerciseType}
    Testosterone -> {BodyFat CVD}
    ExerciseType -> {Testosterone BodyFat CVD}
}")
