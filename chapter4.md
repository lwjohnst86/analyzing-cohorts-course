---
title: 'Presenting results from cohorts'
description: ""
---

## Interpreting the results focusing on showing them

```yaml
type: VideoExercise
key: b1dbfa466f
xp: 50
```

`@projector_key`
24be66708a350c97c6e8d86a7b2f7bf4

---

## What to emphasize when presenting results

```yaml
type: MultipleChoiceExercise
key: 7067db77b1
xp: 50
```



`@possible_answers`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```

---

## Backtransforming results

```yaml
type: NormalExercise
xp: 100
```

yea?

`@instructions`


`@hint`


`@pre_exercise_code`
```{r}
load(url(""))
load(url(""))
library(dplyr)
```

`@sample_code`
```{r}
# Also merge other models?
# Combine unadjusted and adjusted model results.
all_models <- bind_rows(
    unadjusted_models %>% mutate(Model = "Unadjusted"),
    adjusted_models %>% mutate(Model = "Adjusted")
    ) %>% 
    filter(predictor == term) %>% 
    mutate_at(vars(estimate, conf.low, conf.high), funs(exp(.)))

```

`@solution`
```{r}

```

`@sct`
```{r}

```

---

## Calculating absolute and relative risk

```yaml
type: NormalExercise
key: 489eaff7d3
xp: 100
```



`@instructions`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

---

## Communicating the findings through graphs

```yaml
type: VideoExercise
key: b1fd983ad5
xp: 50
```

`@projector_key`
d22c077f314d124f7ab5f28fa0423465

---

## Plotting estimate and uncertainty

```yaml
type: NormalExercise
key: 67e1c0f751
xp: 100
```

{{Convert to tab with 4 steps}}

Statistical analysis used on cohort data usually output some time of regression estimate along with a measure of uncertainty (e.g. 95% confidence interval). Sometimes it makes sense to present these results in a table, but often the better approach is to create a graph instead. Graphs show magnitude, direction, uncertainty, and comparison of results very effectively.

Create a plot of the unadjusted model results that highlights the estimate and uncertainty of the estimate. Include appropriate axis labels.

`@instructions`
- Filter out only estimates of the predictor and only keep the unadjusted results.
- Create a point and error bar plot of the estimates and confidence intervals, with the predictors on the y axis.
- Add a vertical line at 1 for the "null line", using a line type of `"dotted"` for appearance.
- Create an object for the axis labels (for re-use on plots later in the lesson) and add to the plot.

`@hint`
- Filter can take multiple conditions, separated by a comma.
- Use the geom for points and for `errorbarh` (horizontal).
- The `xintercept` must be set when adding a vertical line.
- Create axis labels in ggplot2 with `labs()`.

`@pre_exercise_code`
```{r}
load("datasets/all_models.rda")
library(dplyr)
library(ggplot2)
```

`@sample_code`
```{r}
# Keep only predictor results
predictor_results <- all_models %>% 
    filter(predictor == term, model == "Unadjusted")

# Plot the results
model_plot <- predictor_results %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dotted")
model_plot

# Create a label object for re-use
plot_labels <- labs(y = "Predictors", x = "Odds ratio (95% CI)")

# Apply the labels
model_plot +
    plot_labels
```

`@solution`
```{r}

```

`@sct`
```{r}
success_msg("Excellent! See how this graph shows the uncertainty around individual model estimates? This is an effective way of presenting results from models.")
```

---

## Visualize unadjusted and adjusted model results

```yaml
type: NormalExercise
key: 163d46569b
xp: 100
```

The STROBE guidelines indicate that both "crude" (unadjusted) and adjusted model results be shown. Showing both can be informative and insightful into the research question. Create a plot of your results showing both unadjusted and adjusted models. Do the same steps as in the previous exercise for creating the plot.

`@instructions`
- As in the previous exercise, create a plot of the estimates and confidence intervals of the predictors, but don't filter by model adjustment.
- Expand on the previous exercise by splitting the plot by model using `facet_grid`.

`@hint`
- The vertical line should have a `linetype` of "dotted".
- Select the facetting variable using `vars()`.

`@pre_exercise_code`
```{r}
load("datasets/all_models.rda")
library(dplyr)
library(ggplot2)
plot_labels <- labs(y = "Predictors", x = "Odds ratio (95% CI)")
```

`@sample_code`
```{r}
# Show results of both adjusted and unadjusted
plot_all_models <- all_models %>% 
    filter(___) %>% 
    ggplot(aes(___)) +
    geom_point() +
    ___(height = 0.2) +
    geom_vline(___) +
    # Split plot by model
    ___(rows = ___, scales = "free") +
    plot_labels

# Plot the results
plot_all_models
```

`@solution`
```{r}
# Show results of both adjusted and unadjusted
plot_all_models <- all_models %>% 
    filter(predictor == term) %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dotted") +
    # Split plot by model
    facet_grid(rows = vars(model), scales = "free") +
    plot_labels

# Plot the results
plot_all_models
```

`@sct`
```{r}
success_msg("Great job! You can see that there are large differences in some of the results between unadjusted and adjusted models.")
```

---

## Plotting interactions

```yaml
type: NormalExercise
xp: 100
```

{{tabbed? or sequential for also sex?}}

Given that Framingham is a longitudinal prospective cohort, with repeated measurements, testing for an interaction by time is necessity {{wording?}}.

E.g. a sex or time by predictor interaction

{{TODO: Will need to confirm a time interaction (or just show it regardless...)}}

`@instructions`


`@hint`


`@pre_exercise_code`
```{r}
load("datasets/interaction_models.rda")
```

`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```


---

## Plotting sensitivity analyses

```yaml
type: NormalExercise
key: 0fd338e976
xp: 100
```

{{iterative? or another exericse for subgroup/sensitivity}}

For subgroup.
{{TabExercise with MCE and NE?}}

You decide before hand that you will do a subgroup analysis filtering out those
who dropped out vs those who remained. You find out there is no difference between
these two groups. Do you:

- Not show the null findings and just present your main results
- Show your subgroup analyses in figures, either in the main report or as a supplement

Based on the STROBE guidelines (and just being a good researcher), you should always
show findings that you've done even if they are null or don't have any difference.
    - STROBE: "Report other analyses done—eg analyses of subgroups and interactions, and
    sensitivity analyses"

`@instructions`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

---

## Use tables effectively to show your results

```yaml
type: VideoExercise
key: fceefd27c4
xp: 50
```

`@projector_key`
8ecd82ad25933a2add144c7e10605b7d

---

## Present the basic characteristics of the cohort

```yaml
type: NormalExercise
key: f293d5f02e
xp: 100
```

{{tabbed? 4 steps}}

A classic use for tables is showing the basic characteristics of a cohort dataset, as there are diverse data types and summary statistics that need to be shown. Including a basic participant characteristics table is part of the STROBE requirements. 

Using the carpenter package, create a table showing summary statistics for each data collection visit.

`@instructions`
- Convert `followup_visit_number` and `got_cvd` to factor variables, then set the visit number as the header/columns of the table.
- Add a row for factor variables, using `number (percent)` as a summary statistic.
- Add a row for the predictor variables, body mass, and age using `median (interquartile range)` as the statistic.
- Rename the table headers to "Measures", "Baseline", "Second followup", and "Third followup", then build the table into a markdown format.

`@hint`
- Select the variables using `vars()` in `mutate_at`.
- Carpenter summary statistic functions begin with `stat_`; choose the version for number and percent.
- The predictors are total cholesterol, systolic and diastolic blood pressure, and fasting blood glucose.
- The new column headers should be passed as a character vector.

`@pre_exercise_code`
```{r}
load("datasets/tidied_framingham.rda")
library(carpenter)
library(dplyr)
```

`@sample_code`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    mutate_at(vars(followup_visit_number, got_cvd), as.factor) %>% 
    outline_table(header = "followup_visit_number") %>% 
    add_rows(c("got_cvd", "sex", "education_combined"), stat = stat_nPct) %>% 
    add_rows(c("participant_age", "body_mass_index",
               "total_cholesterol", "systolic_blood_pressure",
               "diastolic_blood_pressure", "fasting_blood_glucose"), 
             stat = stat_medianIQR) %>% 
    renaming("header", c("Measures", "Baseline", "Second followup", "Third followup"))

# Build the table and convert to markdown form
build_table(characteristics_table)
```

`@solution`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    mutate_at(vars(followup_visit_number, got_cvd), as.factor) %>% 
    outline_table(header = "followup_visit_number") %>% 
    add_rows(c("got_cvd", "sex", "education_combined"), stat = stat_nPct) %>% 
    add_rows(c("participant_age", "body_mass_index",
               "total_cholesterol", "systolic_blood_pressure",
               "diastolic_blood_pressure", "fasting_blood_glucose"), 
             stat = stat_medianIQR) %>% 
    renaming("header", c("Measures", "Baseline", "Second followup", "Third followup"))

# Build the table and convert to markdown form
build_table(characteristics_table)
```

`@sct`
```{r}
success_msg("Nice job! You've gotten the data formatted as a table for easy inclusion in a document or report and have provided basic participant characteristics from each cohort visit.")
```

---

## Supplemental tables of raw numbers for results

```yaml
type: NormalExercise
key: 15721e102b
xp: 100
```

{{convert to tabbed of 3?}}

While the main messaging and presentation of results should emphasize figures over tables, often it is useful to other researchers (especially those doing meta-analyses) that the raw model results be given as well. Here we can use tables to give this data, as a supplement to the figure.

Provide the estimates and 95% confidence intervals of the unadjusted and adjusted model results in a format that is nearly suitable for inclusion in a document.

`@instructions`
- Keeping only the predictor estimates, round the estimates and CI to one digit.
- Using the `glue` function, create a new variable that puts the estimate and CI together in the form: `estimate (lower, upper)`.
- Keeping only the model, predictor, and combined estimate and CI variables, spread the data so the unadjusted and adjusted model results have their own columns.
- Convert the data frame into a Markdown table using `kable`.

`@hint`
- `mutate_at` applies a function (second argument) to a list of variables (first argument).
- Use `{}` to pass data/variables into the `glue` function.
- When spreading, choose 1) the variable that will make up the name of the new columns and 2) the variable that provides the values for the new columns.


`@pre_exercise_code`
```{r}
load("datasets/tidied_framingham.rda")
library(knitr)
library(glue)
library(dplyr)
library(tidyr)
```

`@sample_code`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    filter(predictor == term) %>% 
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 1) %>% 
    mutate(estimate_ci = glue("{estimate} ({conf.low}, {conf.high})"),
           predictor = predictor %>% 
               str_replace("scaled_", "") %>% 
               str_replace_all("_", " ")) %>%
    select(model, predictor, estimate_ci) %>% 
    spread(model, estimate_ci)
table_model_results

# Create a Markdown table
kable(table_model_results, caption = "Caption here")
```

`@solution`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    filter(predictor == term) %>% 
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 1) %>% 
    mutate(estimate_ci = glue("{estimate} ({conf.low}, {conf.high})"),
           predictor = predictor %>% 
               str_replace("scaled_", "") %>% 
               str_replace_all("_", " ")) %>%
    select(model, predictor, estimate_ci) %>% 
    spread(model, estimate_ci)
table_model_results

# Create a Markdown table
kable(table_model_results, caption = "Caption here")
```

`@sct`
```{r}
success_msg("Amazing! You've wrangled the data and prepared it to be presented as a table! You can now easily add this to your manuscript (especially easy if you use R Markdown).")
```
