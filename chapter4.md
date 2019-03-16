---
title: 'Presentation of results from cohort analyses'
description: 'Cohorts are important scientific sources of health and wellness information. Because of this, how results are presented needs to be carefully considered. The medium of presentation, be it plots or tables, can impact how the findings are seen and consumed. In this chapter we will cover some tips and ways of presenting cohort findings.'
---

## Presenting cohort findings is tricky, be careful

```yaml
type: VideoExercise
key: b1dbfa466f
xp: 50
```

`@projector_key`
24be66708a350c97c6e8d86a7b2f7bf4

---

## Adding more details to each model item in a list

```yaml
type: BulletExercise
key: 921d9175f4
xp: 100
```

Imagine you've ran several models, based on what you learned in chapter 3. You:

- Scaled predictors to compare estimates.
- Set confounders and other predictors as baseline age, sex, smoking, and education.
- Have each predictor with unadjusted and adjusted models (time and subject ID were included in all).
- Tidied models and exponentiated estimates.

You have 8 models in total, stored as a list. There are a couple of things we should add to each model to differentiate each from the other models. Use `map` from the purrr package to wrangle each model item simultaneously.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/2bb231430c5899236ee8b8d0af4b229036657d3a/unadjusted_models_list.rda"))
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/13d5aaceecc89a74b4f323546401d409a605acc2/adjusted_models_list.rda"))
library(dplyr)
library(purrr)
```

***

```yaml
type: NormalExercise
key: 0dffe6f56f
xp: 50
```

`@instructions`
- Create a predictor column using the row number that the predictor is in from the `term` variable, then add a model column to indicate "adjustment".

`@hint`
- Add the predictor by selecting the element number from the `term` variable with the predictor information.

`@sample_code`
```{r}
# Add predictor and model type to each list item
unadjusted_models_list <- ___(
    unadjusted_models_list,
    ~ .x %>% ___(predictor = term[___], ___)
)
```

`@solution`
```{r}
# Add predictor and model type to each list item
unadjusted_models_list <- map(
    unadjusted_models_list,
    ~ .x %>% mutate(predictor = term[2], model = "Unadjusted")
)
```

`@sct`
```{r}
success_msg("Nice!")
```

***

```yaml
type: NormalExercise
key: b91f78ffbb
xp: 50
```

`@instructions`
- Do the same thing for the adjusted model list.

`@hint`
- Map onto the adjusted model list.

`@sample_code`
```{r}
# Do the same for adjusted model list
adjusted_models_list <- 

```

`@solution`
```{r}
# Do the same for adjusted model list
adjusted_models_list <- map(
    adjusted_models_list,
    ~ .x %>% mutate(predictor = term[2], model = "Adjusted")
)
```

`@sct`
```{r}
success_msg("Excellent! You made use of R's strength of functional programming rather than use a for loop.")
```

---

## Combining the list of models into one dataframe

```yaml
type: NormalExercise
key: f30b964cce
xp: 100
```

The most efficient approach to later plotting and creating tables is to have all models in a single dataframe. You've already prepared them a bit, now its time to combine them together so you can continue wrangling.

`@instructions`
- Using `bind_rows`, put the two model list objects together.
- Continuing to pipe, add an outcome column.
- Finally, filter out all but the predictor estimates.

`@hint`
- Filter so only the predictor estimate rows remain (when predictor and term are the same).

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/2bb231430c5899236ee8b8d0af4b229036657d3a/unadjusted_models_list.rda"))
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/13d5aaceecc89a74b4f323546401d409a605acc2/adjusted_models_list.rda"))
library(dplyr)
library(purrr)
unadjusted_models_list <- map(
    unadjusted_models_list,
    ~ .x %>% mutate(predictor = term[2], model = "Unadjusted")
)
adjusted_models_list <- map(
    adjusted_models_list,
    ~ .x %>% mutate(predictor = term[2], model = "Adjusted")
)
```

`@sample_code`
```{r}
# Combine models, add outcome, keep predictor estimates
all_models <- ___ %>% 
    ___ %>% 
    ___

# Check the model dataframe

```

`@solution`
```{r}
# Combine models, add outcome, keep predictor estimates
all_models <- bind_rows(unadjusted_models_list, adjusted_models_list) %>% 
    mutate(outcome = "got_cvd") %>% 
    filter(predictor == term)

# Check the model dataframe
all_models
```

`@sct`
```{r}
success_msg("Well done! You've now bound all models together and continued wrangling them.")
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

Create a plot of the unadjusted model results that highlights the estimate and uncertainty of the estimate.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/56fed8010409f87de562920a827364b3a8a5ffdf/all_models.rda"))
library(dplyr)
library(ggplot2)
all_models <- all_models %>% 
    filter(predictor == term)
```

***

```yaml
type: NormalExercise
key: 19bfd714ac
xp: 30
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
key: 4ffd9e23ed
xp: 35
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
    ___()

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
    geom_errorbarh()

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
key: f5fe48b671
xp: 35
```

`@instructions`
- Add a vertical line at 1 for the "center line".

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
    geom_errorbarh() +
    # Add vertical line
    ___(___)

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
    geom_errorbarh() +
    # Add vertical line
    geom_vline(xintercept = 1)

# Check the plot
model_plot
```

`@sct`
```{r}
success_msg("Excellent! See how this graph shows the uncertainty around individual model estimates? This is an effective way of presenting results from models.")
```

---

## Create a more polished plot

```yaml
type: NormalExercise
key: f6857cd149
xp: 100
```

Now that we've created this plot, let's polish it up. We want it to be "publication quality", since we'll eventually present this figure to others.

As with the previous exercise, use the `unadjusted_results` dataframe you created to plot the findings. This time, make the plot more polished and presentable.

`@instructions`
- Add the `aes()` variables, the point, error bar, and vertical center line.
- Set the point `size` to 3, the error bar `height` to 0.1, and the `linetype` to dotted.
- Include appropriate axis labels (the "Predictors" on the y and the "Odds Ratio (95% CI)" on the x). Remember, CI is the confidence interval.
- Change the theme to `theme_bw()`.

`@hint`
- The labels should be of the form `x = "Axis Label"` (for the x-axis for instance).

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/56fed8010409f87de562920a827364b3a8a5ffdf/all_models.rda"))
library(dplyr)
library(ggplot2)
unadjusted_results <- all_models %>% 
    filter(model == "Unadjusted", predictor == term)
```

`@sample_code`
```{r}
# Make the plot more polished
model_plot <- unadjusted_results %>% 
    ggplot(___) +
    ___ +
    ___ +
    ___ +
    labs(___, ___) +
    ___

# Plot it
___
```

`@solution`
```{r}
# Make the plot more polished
model_plot <- unadjusted_results %>% 
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point(size = 3) +
    geom_errorbarh(height = 0.1) +
    geom_vline(xintercept = 1, linetype = "dotted") +
    labs(y = "Predictors", x = "Odds ratio (95% CI)") +
    theme_bw()

# Plot it
model_plot
```

`@sct`
```{r}
success_msg("Amazing! You have a very nice figure now that is ready to be presented to others! There are other themes to use if you don't like this one.")
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
- As in the previous exercise, create a plot of the estimates and confidence intervals of the predictors.
- This time, don't filter by model adjustment.
- Make the plot pretty as in the previous exercise (including the `labs`).
- Expand on the previous exercise by splitting the plot by model using `facet_grid`.

`@hint`
- The vertical line should have a `linetype` of "dotted".
- Select the facetting variable using `vars()`.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/56fed8010409f87de562920a827364b3a8a5ffdf/all_models.rda"))
library(dplyr)
library(ggplot2)
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
    labs(___, ___)

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
    labs(y = "Predictors", x = "Odds ratio (95% CI)")

# Plot the results
plot_all_models
```

`@sct`
```{r}
success_msg("Great job! You can see that there are large differences in some of the results between unadjusted and adjusted models.")
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
library(stringr)
all_models <- all_models %>% 
    filter(predictor == term)
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
