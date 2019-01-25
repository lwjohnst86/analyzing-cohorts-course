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
type: PureMultipleChoiceExercise
key: bc58bede32
xp: 50
```

- MCQ/text: Which is the most appropriate language to use when describing these
results:
    - {large effect size} {strong causal language}
    - .. etc. fill out later.
- Do coding exercise with effect size then into comment about proper language.
    

{{Bradford Hill *guideline* is also covered in the other epi courses... but
worth it to repeat since it is important}}

{{focus on these aspects: strength/effect size, consistency/replicability,
temporality, biological plausibility... these also apply to all aspects of causal
reasoning in all of science... even with all of these, may not be causal, but
have a common causal downstream factor.}}

Thinking about using stronger language

`@hint`


`@possible_answers`


`@feedback`


---

## Preparing model results for presentation

```yaml
type: NormalExercise
key: 0216e3a4ee
xp: 100
```

Imagine you've ran several models, based on what you learned in chapter 3. You:

- Scaled predictors to compare estimates.
- Set covariates as baseline age, sex, smoking, and education.
- Have each predictor with unadjusted and adjusted models (time and subject ID were included in all).
- Tidied models and exponentiated estimates.

You have 8 models in total, stored as a list. The most efficient approach is to have them all as a single dataframe so you can easily create plots or tables from them. You need to wrangle the results to get them into the proper form.

`@instructions`
- Add predictor column and model type column.

`@hint`
- The predictor is the second element of the term variable.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/2bb231430c5899236ee8b8d0af4b229036657d3a/unadjusted_models_list.rda"))
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/13d5aaceecc89a74b4f323546401d409a605acc2/adjusted_models_list.rda"))
library(dplyr)
library(purrr)
```

`@sample_code`
```{r}
# Add predictor and model type
unadjusted_models_list <- map(
    unadjusted_models_list,
    ~ .x %>% mutate(predictor = term[2], model = "Unadjusted")
)

# Add predictor and model type
unadjusted_models_list <- map(
    adjusted_models_list,
    ~ .x %>% mutate(predictor = term[2], model = "Adjusted")
)

# Combine model, add outcome, keep predictor estimates
bind_rows(unadjusted_models_list, adjusted_models_list) %>% 
    mutate(outcome = "got_cvd") %>% 
    filter(predictor == term)
```

`@solution`
```{r}

unadjusted_models_list <- map(
    unadjusted_models_list,
    ~ .x %>% 
        mutate(predictor = term[2], model = "Unadjusted")
)

unadjusted_models_list <- map(
    adjusted_models_list,
    ~ .x %>% 
        mutate(predictor = term[2], model = "Adjusted")
)

# Combine unadjusted and adjusted model results
bind_rows(unadjusted_models_list, adjusted_models_list) %>% 
    mutate(outcome = "got_cvd") %>% 
    filter(predictor == term)
```

`@sct`
```{r}
success_msg("Well done! Using the purrr package functions is a great way of making use of R's functional programming strengths so you can wrangle each model in the list simultaneously.")
```

---

## Insert exercise title here

```yaml
type: TabExercise
key: a2be7c9ce5
xp: 100
```



`@pre_exercise_code`
```{r}

```

***

```yaml
type: NormalExercise
key: ddc8c50699
xp: 35
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: a85bee2767
xp: 35
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: 52bf5f28da
xp: 30
```

`@instructions`


`@hint`


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

## Communicating cohort findings through graphs

```yaml
type: VideoExercise
key: b1fd983ad5
xp: 50
```

`@projector_key`
d22c077f314d124f7ab5f28fa0423465

---

## Plotting model estimate and uncertainty

```yaml
type: TabExercise
key: 69007ab10b
xp: 100
```

Statistical analysis used on cohort data usually output some time of regression estimate along with a measure of uncertainty (e.g. 95% confidence interval). Sometimes it makes sense to present these results in a table, but often the better approach is to create a graph instead. Graphs show magnitude, direction, uncertainty, and comparison of results very effectively.

Create a plot of the unadjusted model results that highlights the estimate and uncertainty of the estimate. Include appropriate axis labels.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/56fed8010409f87de562920a827364b3a8a5ffdf/all_models.rda"))
library(dplyr)
library(ggplot2)
```

***

```yaml
type: NormalExercise
key: 1bba556c19
xp: 25
```

`@instructions`
- Keep only the unadjusted results.

`@hint`
- Filter takes a logic condition.

`@sample_code`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    ___(___)

# Check filtered data
___
```

`@solution`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted")

# Check filtered data
unadjusted_results
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 66f5089420
xp: 25
```

`@instructions`
- Create a point and error bar plot of the estimates and confidence intervals, with the predictors on the y axis.

`@hint`
- Use the geom for points and for `errorbarh` (horizontal).

`@sample_code`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted")

# Create a dot and error bar plot
model_plot <- ___ %>% 
    ggplot(aes(___)) +
    ___() +
    # height of 0.2 for aesthetics
    ___(height = 0.2)

# Check the plot
___
```

`@solution`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted")

# Create a dot and error bar plot
model_plot <- unadjusted_results %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    # height of 0.2 for aesthetics
    geom_errorbarh(height = 0.2)

# Check the plot
model_plot
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 0e3b13549a
xp: 25
```

`@instructions`
- Add a vertical line at 1 for the "null line", using a line type of `"dotted"` for appearance.

`@hint`
- The `xintercept` must be set when adding a vertical line.

`@sample_code`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted")

# Create a dot and error bar plot
model_plot <- unadjusted_results %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    # Add vertical line
    ___(___, ___)

# Check the plot
___
```

`@solution`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted")

# Create a dot and error bar plot
model_plot <- unadjusted_results %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    # Add vertical line
    geom_vline(xintercept = 1, linetype = "dotted")

# Check the plot
model_plot
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 3418387bf1
xp: 25
```

`@instructions`
- Create an object for the axis labels (for re-use on plots later in the lesson) and add to the plot.

`@hint`
- Create axis labels in ggplot2 with `labs()`.

`@sample_code`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted")

# Create a dot and error bar plot
model_plot <- unadjusted_results %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dotted")

# Create a label object for re-use
plot_labels <- ___(___ = "Predictors", ___ = "Odds ratio (95% CI)")

# Make the plot with labels
___ +
    # Apply labels
    ___
```

`@solution`
```{r}
# Keep only unadjusted models
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted")

# Create a dot and error bar plot
model_plot <- unadjusted_results %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dotted")

# Create a label object for re-use
plot_labels <- labs(y = "Predictors", x = "Odds ratio (95% CI)")

# Make the plot with labels
model_plot +
    # Apply labels
    plot_labels
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
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/56fed8010409f87de562920a827364b3a8a5ffdf/all_models.rda"))
library(dplyr)
library(ggplot2)
plot_labels <- labs(y = "Predictors", x = "Odds ratio (95% CI)")
```

`@sample_code`
```{r}
# Show results of both adjusted and unadjusted
plot_all_models <- all_models %>% 
    ggplot(aes(___)) +
    ___() +
    ___(height = 0.2) +
    geom_vline(___) +
    # Split plot by model
    ___(rows = ___) +
    plot_labels

# Plot the results
plot_all_models
```

`@solution`
```{r}
# Show results of both adjusted and unadjusted
plot_all_models <- all_models %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dotted") +
    # Split plot by model
    facet_grid(rows = vars(model)) +
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
key: 44c0af6008
xp: 100
```

{{tabbed? or sequential for also sex?}}

Given that Framingham is a longitudinal prospective cohort, with repeated measurements, testing for an interaction by time is necessity {{wording?}}.

E.g. a sex or time by predictor interaction

{{TODO: Will need to confirm a time interaction (or just show it regardless...)}}

`@instructions`
- Check whether any interaction has a p-value less than 0.10.

`@hint`
- Use

`@pre_exercise_code`
```{r}
load("datasets/interaction_models.rda")
```

`@sample_code`
```{r}
View(interaction_models)

interaction_models %>% 
    filter(p.value < 0.10)


```

`@solution`
```{r}

```

`@sct`
```{r}
success_msg("Amazing!")
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
type: TabExercise
key: cb7b2cfe06
xp: 100
```

A classic use for tables is showing the basic characteristics of a cohort dataset, as there are diverse data types and summary statistics that need to be shown. Including a basic participant characteristics table is part of the STROBE requirements. This table can be quite informative for others when they interpret your analysis results.

Using the carpenter package, create a table showing summary statistics for each data collection visit.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/25722a0770c3779d3290fd5628362c56a9d7d21b/tidied_framingham.rda"))
library(carpenter)
library(dplyr)
```

***

```yaml
type: NormalExercise
key: c653bbf2fa
xp: 25
```

`@instructions`
- Convert `followup_visit_number` and `got_cvd` to factor variables, then set the visit number as the header/columns of the table.

`@hint`
- Select the variables using `vars()` in `mutate_at`.

`@sample_code`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    # Convert variables to factor
    mutate_at(___, ___) %>% 
    # Set variable as table column
    outline_table(header = ___) 

# Check the table
___
```

`@solution`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    mutate_at(vars(followup_visit_number, got_cvd), as.factor) %>% 
    outline_table(header = "followup_visit_number") 

# Check the table
characteristics_table
```

`@sct`
```{r}
success_msg("Nice!")
```

***

```yaml
type: NormalExercise
key: 3f50416623
xp: 25
```

`@instructions`
- Add a row for the outcome, sex, and education (combined) variables, using `number (percent)` as a summary statistic.

`@hint`
- Carpenter summary statistic functions begin with `stat_`; choose the version for number and percent.

`@sample_code`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    mutate_at(vars(followup_visit_number, got_cvd), as.factor) %>% 
    outline_table(header = "followup_visit_number") %>% 
    # Show n (%) for factors as rows
    add_rows(c(___, ___, ___), stat = ___)

# Check the table
___
```

`@solution`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    mutate_at(vars(followup_visit_number, got_cvd), as.factor) %>% 
    outline_table(header = "followup_visit_number") %>% 
    # Show n (%) for factors as rows
    add_rows(c("got_cvd", "sex", "education_combined"), stat = stat_nPct)

# Check the table
characteristics_table
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: cf370dcbc3
xp: 25
```

`@instructions`
- Add a row for the predictor variables, body mass, and age using `median (interquartile range)` as the statistic.

`@hint`
- The predictors are total cholesterol, systolic and diastolic blood pressure, and fasting blood glucose.

`@sample_code`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    mutate_at(vars(followup_visit_number, got_cvd), as.factor) %>% 
    outline_table(header = "followup_visit_number") %>% 
    add_rows(c("got_cvd", "sex", "education_combined"), stat = stat_nPct) %>% 
    # Show median (range) for continuous variables
    ___(___, ___)

# Check the table
___
```

`@solution`
```{r}
# Create a table of summary statistics
characteristics_table <- tidied_framingham %>% 
    mutate_at(vars(followup_visit_number, got_cvd), as.factor) %>% 
    outline_table(header = "followup_visit_number") %>% 
    add_rows(c("got_cvd", "sex", "education_combined"), stat = stat_nPct) %>% 
    # Show median (range) for continuous variables
    add_rows(c("participant_age", "body_mass_index",
               "total_cholesterol", "systolic_blood_pressure",
               "diastolic_blood_pressure", "fasting_blood_glucose"), 
             stat = stat_medianIQR) 

# Check the table
characteristics_table
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 81f9f129af
xp: 25
```

`@instructions`
- Rename the table headers to "Measures", "Baseline", "Second followup", and "Third followup", then build the table into markdown format.

`@hint`
- The new column headers should be passed as a character vector.

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
    # Rename headers to better titles
    renaming(___, c(___))

# Build the table and convert to markdown form
build_table(___)
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
    # Rename headers to better titles
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
type: TabExercise
key: e1034d1d86
xp: 100
```

While the main messaging and presentation of results should emphasize figures over tables, often it is useful to other researchers (especially those doing meta-analyses) that the raw model results be given as well. Here we can use tables to give this data, as a supplement to the figure.

Provide the estimates and 95% confidence intervals of the unadjusted and adjusted model results in a format that is nearly suitable for inclusion in a document.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/56fed8010409f87de562920a827364b3a8a5ffdf/all_models.rda"))
library(knitr)
library(glue)
library(dplyr)
library(tidyr)
```

***

```yaml
type: NormalExercise
key: f26d103841
xp: 35
```

`@instructions`
- Keeping only the predictor estimates, round the estimates and CI to two digits.

`@hint`
- `mutate_at` applies a function (second argument) to a list of variables (first argument) with `vars()`.

`@sample_code`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    # Round values
    mutate_at(___, ___, digits = ___)

# View wrangled data
table_model_results
```

`@solution`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    # Round values
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 2)

# View wrangled data
table_model_results
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 3934cab889
xp: 35
```

`@instructions`
- Using the `glue` function, create a new variable that puts the estimate and CI together in the form: `estimate (lower, upper)`.

`@hint`
- Use `{}` to pass data/variables into the `glue` function.

`@sample_code`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 2) %>% 
    # Use glue function to combine variables
    mutate(estimate_ci = ___("___"),
           # Tidy up predictor
           predictor = predictor %>% 
               str_replace("scaled_", "") %>% 
               str_replace_all("_", " "))

# View wrangled data
table_model_results
```

`@solution`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 2) %>% 
    # Use glue function to combine variables
    mutate(estimate_ci = glue("{estimate} ({conf.low}, {conf.high})"),
           # Tidy up predictor
           predictor = predictor %>% 
               str_replace("scaled_", "") %>% 
               str_replace_all("_", " "))

# View wrangled data
table_model_results
```

`@sct`
```{r}
success_msg("Amazing!")
```

***

```yaml
type: NormalExercise
key: f015c03292
xp: 30
```

`@instructions`
- Keep the model, predictor, and combined estimate and CI variables, spread the data so the unadjusted and adjusted model results have their own columns, and then create the `kable()` table.

`@hint`
- When spreading, choose 1) the variable that will make up the name of the new columns and 2) the variable that provides the values for the new columns.

`@sample_code`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 2) %>% 
    mutate(estimate_ci = glue("{estimate} ({conf.low}, {conf.high})"),
           predictor = predictor %>% 
               str_replace("scaled_", "") %>% 
               str_replace_all("_", " ")) %>%
    # Keep then spread variables for final table
    select(___) %>% 
    ___(___, ___)

# Create a Markdown table
___(___, caption = "Estimates and 95% CI from all models.")
```

`@solution`
```{r}
# Prepare the results for the table
table_model_results <- all_models %>% 
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 2) %>% 
    mutate(estimate_ci = glue("{estimate} ({conf.low}, {conf.high})"),
           predictor = predictor %>% 
               str_replace("scaled_", "") %>% 
               str_replace_all("_", " ")) %>%
    # Keep then spread variables for final table
    select(model, predictor, estimate_ci) %>% 
    spread(model, estimate_ci)

# Create a Markdown table
kable(table_model_results, caption = "Estimates and 95% CI from all models.")
```

`@sct`
```{r}
success_msg("Amazing! You've wrangled the data and prepared it to be presented as a table! You can now easily add this to your manuscript (especially easy if you use R Markdown).")
```
