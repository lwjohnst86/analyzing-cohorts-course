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

{{Convert to tab, combine with exercise below? Or just split it up.}}

Statistical analysis used on cohort data usually output some time of regression estimate along with a measure of uncertainty (e.g. 95% confidence interval). Sometimes it makes sense to present these results in a table, but often the better approach is to create a graph instead. Graphs show magnitude, direction, uncertainty, and comparison of results very effectively.

Create a plot of the unadjusted model results that highlights the estimate and uncertainty of the estimate. Include appropriate axis labels.

`@instructions`
- Filter out only estimates of the predictor and only keep the unadjusted results.
- Create a point and error bar plot of the estimates and confidence intervals, using `height = 0.2` for appearance.
- Add a vertical line at 1 for the "null line", using a line type of `"dotted"` for appearance.
- Create an object for the axis labels (for re-use on plots later in the lesson) and add to the plot.

`@hint`


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
    ggplot(aes(y = term, x = estimate, xmin = conf.low, xmax = conf.high)) +
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

The STROBE guidelines indicate that both "crude" (unadjusted) and adjusted model results be shown. Showing both can be informative and insightful into the research question. Create a plot of your results showing both unadjusted and adjusted models.

`@instructions`
- As in the previous exercise, create a plot of the estimates and confidence intervals of the predictors, but don't filter by model adjustment.
- Expand on the previous exercise by splitting the plot by model using `facet_grid`.

`@hint`


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
    filter(predictor == term) %>% 
    ggplot(aes(y = term, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_errorbarh(aes(height = 0.2)) +
    geom_point() +
    geom_vline(xintercept = 1, linetype = "dotted") +
    facet_grid(rows = vars(model), scales = "free") +
    plot_labels
plot_all_models
```

`@solution`
```{r}

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

```{r}
# TODO: Will need to confirm a time interaction (or just show it regardless...)
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

## Plotting interactions and subgroups

```yaml
type: NormalExercise
key: 0fd338e976
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

## Using tables to presenting your results

```yaml
type: VideoExercise
key: fceefd27c4
xp: 50
```

`@projector_key`
8ecd82ad25933a2add144c7e10605b7d

---

## Basic characteristics of cohorts

```yaml
type: NormalExercise
key: f293d5f02e
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

## Supplemental tables for numerical results

```yaml
type: NormalExercise
key: 15721e102b
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
