---
title: 'Introduction to cohorts and to analyzing them'
description: 'In this chapter we will cover the basics of what a cohort is, an approach to analyzing cohort data, and some first steps in exploring the data. You''ll also learn what type of data values to be aware of and to consider when dealing with cohort datasets.'
free_preview: true
---

## Introduction to cohort studies

```yaml
type: VideoExercise
key: b2111dc061
lang: r
xp: 50
skills: 1
```

`@projector_key`
fd067459a73b16863b609297f96ac32c

---

## What makes it a cohort?

```yaml
type: MultipleChoiceExercise
key: ed0789164c
lang: r
xp: 50
skills: 1
```

The Framingham cohort was set up to study what might influence the risk of cardiovascular disease (CVD). People from the town of Framingham, USA were recruited and followed over time. Data was collected on risk factors and CVD outcomes every few years.

What makes the Framingham dataset a *cohort*? The `framingham` dataset is loaded for you to explore if you would like. The dataset has yet to be fully tidied, which we will do in Chapter 2.

`@possible_answers`
- It studies a disease (CVD).
- Participants all came from the town of Framingham, USA.
- Participants were followed over time.
- Participants had risk factors measured.

`@hint`
- Cohorts are people who have *something in common*.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
framingham$time <- NULL
```

`@sct`
```{r}
msg1 <- "Almost, but incorrect. While cohorts often are used to study a disease, this doesn't make it a cohort."
msg2 <- "Correct! Cohorts are people who share a common characteristic. In this case, the participants come from the same town and so have a similar environment."
msg3 <- "Almost, but incorrect. While cohorts always include a time component, this alone doesn't make it a cohort."
msg4 <- "Incorrect. While all cohorts have risk factors measured, this alone doesn't make it a cohort."
ex() %>% check_mc(2, feedback_msgs = c(msg1, msg2, msg3, msg4))
```

---

## What cohort type is the Framingham Heart Study?

```yaml
type: TabExercise
key: f9d57e327c
xp: 100
```

Usually you can determine the cohort design from the variables in the dataset. Which variables in the Framingham study give us an indication of the cohort design? What is the cohort design?

We expect you to be (at least a bit) familiar with the tidyverse packages and functions, since you will need to use packages such as `dplyr`, `tidyr`, and `ggplot2` throughout this course. Note that `framingham` has not yet been tidied up, which we will do later in the course.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
framingham$time <- NULL
```

`@sample_code`
```{r}
# Check out the variable names
names(framingham)

# Select two columns that indicate design
framingham %>% 
    select(_____, _____)
```

***

```yaml
type: NormalExercise
key: fbd1546da1
xp: 50
```

`@instructions`
- Familiarize yourself with the variables in the `framingham` dataset.
- Select the two variables that indicate `framingham`'s cohort design.

`@hint`
- The Framingham cohort was designed to study the disease `cvd`.

`@sample_code`
```{r}
# Check out the variable names
names(framingham)

# Select two columns that indicate design
framingham %>% 
    select(_____, _____)
```

`@solution`
```{r}
# Check out the variable names
names(framingham)

# Select two columns that indicate design
framingham %>% 
    select(period, cvd)
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: MultipleChoiceExercise
key: c22855322d
xp: 50
```

`@question`
- What is the cohort design?

`@possible_answers`
- Prospective.
- Retrospective.
- Neither.
- Both.

`@hint`
- Recall that the study was designed to examine cardiovascular disease *over time*.

`@sct`
```{r}
msg1 = "Correct."
msg2 = "Incorrect."
msg3 = "Incorrect."
msg4 = "Incorrect."
ex() %>% check_mc(1, feedback_msgs = c(msg1, msg2, msg3, msg4))
success_msg("Nice job! You've identified that period (the time component) and CVD (the disease) tell us that Framingham is a prospective cohort design!")
```

---

## Cohort types, variables, and the Framingham Study

```yaml
type: VideoExercise
key: a537fbe14a
lang: r
xp: 50
skills: 1
```

`@projector_key`
9e3d8b35b89128ebb91908d3aa815cf1

---

## Select the outcome and some exposures

```yaml
type: NormalExercise
key: 98e9f6d5d6
lang: r
xp: 100
skills: 1
```

It's important to know what each variable represents so you can analyze the data properly. Usually it's fairly easy to identify the outcome. However, knowing which are potential predictors can be tricky, since modern cohorts often measure hundreds of variables on each participant. 

Initially, it can be helpful to keep only the variables of interest. For now, select a few interesting variables to explore them more and tidy them up by renaming them so they are more descriptive.

`@instructions`
- Run `names(framingham)` in the console to find the exact names of the variables. 
- Choose the correct outcome for cardiovascular disease (CVD). Rename it to `got_cvd`.
- Rename the four predictors to `total_cholesterol`, `body_mass_index` and `currently_smokes`.
- Rename the `period` variable to `followup_visit_number`.

`@hint`
- Rename `bmi` to `body_mass_index`, `totchol` to `total_cholesterol`, and `cursmoke` to `currently_smokes`.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
```

`@sample_code`
```{r}
# Select and rename the potential predictors and outcome
explore_framingham <- framingham %>%
    select(
        # Format: new_variable_name = old_variable_name
        # Outcome
        _____ = cvd,
        # Predictors
        _____ = totchol,
        _____ = bmi,
        _____ = cursmoke,
        # Visit number
        _____ = period 
    )
explore_framingham
```

`@solution`
```{r}
# Select and rename the potential predictors and outcome
explore_framingham <- framingham %>%
    select(
        # Format: new_variable_name = old_variable_name
        # Outcome
        got_cvd = cvd,
        # Predictors
        total_cholesterol = totchol,
        body_mass_index = bmi,
        currently_smokes = cursmoke,
        # Visit number
        followup_visit_number = period 
    )
explore_framingham
```

`@sct`
```{r}
success_msg("Great job! You've selected and renamed the variables correctly.")
```

---

## Simple summary of the exposures by outcome

```yaml
type: NormalExercise
key: 45b64907b1
xp: 100
```

Early in any analysis of cohort datasets, its important to get some simple summaries of the exposures by those with and without the disease. Even more so when there is a time component to the study, so you can identify how variables change over time.

Using what was shown in the video, calculate some means based on groupings.

`@instructions`
- Group the data by `followup_visit_number` and `got_cvd` using the `dplyr` function `group_by()`.
- Calculate the mean for `body_mass_index`. `total_cholesterol`, and `currently_smokes` using `summarize()` and `mean()`.
- Make sure that `mean()` drops `NA` values by setting the `na.rm` argument to `TRUE`.

`@hint`
- Use `na.rm = TRUE` with `mean()`.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
explore_framingham <- framingham %>%
    select(
        got_cvd = cvd,
        total_cholesterol = totchol,
        body_mass_index = bmi,
        currently_smokes = cursmoke,
        followup_visit_number = period
    )
```

`@sample_code`
```{r}
explore_framingham %>% 
    # Group by visit and CVD status
    group_by(___, ___) %>% 
    # Mean of body mass, smoking, and cholesterol
    summarize(
        body_mass_mean = mean(___, ___),
        smokes_mean = ___,
        cholesterol_mean = ___
    )
```

`@solution`
```{r}
explore_framingham %>% 
    # Group by visit and CVD status
    group_by(followup_visit_number, got_cvd) %>% 
    # Mean of body mass, smoking, and cholesterol
    summarize(
        body_mass_mean = mean(body_mass_index, na.rm = TRUE),
        smokes_mean = mean(currently_smokes, na.rm = TRUE),
        cholesterol_mean = mean(total_cholesterol, na.rm = TRUE)
    )
```

`@sct`
```{r}
success_msg("Awesome! You learned how to compare the difference in some basic predictors in those who did and did not get CVD over the study duration.")
```

---

## Prevalence and incidence in cohorts

```yaml
type: VideoExercise
key: 382b3edde1
lang: r
xp: 50
skills: 1
```

`@projector_key`
d8b40a3d5d81b2b050f65eb79581aa42

---

## Count number of participants and cases per visit

```yaml
type: TabExercise
key: 2ba20dff0f
xp: 100
```

Here, you will count the number of cases and non-cases for both prevalent myocardial infarction (MI), or `prevalent_mi`, and coronary heart disease (CHD), or `prevalent_chd`, at each visit. Remember, for longitudinal data you need to count by the time period since each participant will have several rows for each of the data collection visits.

Both dplyr and tidyr are loaded and all variables have been added back into `explore_framingham`.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
explore_framingham <- framingham %>%
    rename(
        got_cvd = cvd, 
        total_cholesterol = totchol,
        body_mass_index = bmi,
        currently_smokes = cursmoke,
        followup_visit_number = period,
        prevalent_chd = prevchd,
        prevalent_mi = prevmi
    )
```

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>%
    count(___)
```

***

```yaml
type: NormalExercise
key: bfd1783eee
xp: 30
```

`@instructions`
- Use `count()` to find the number of participants at each `followup_visit_number`.

`@hint`
- The code is `count(followup_visit_number)`.

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>%
    count(___)
```

`@solution`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: c69b3c3b86
xp: 35
```

`@instructions`
- Count the number of participants with `prevalent_mi` at each `followup_visit_number`.

`@hint`
- Include both variables in `count()` separated by a comma.

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI per visit
explore_framingham %>% 
    count(___, ___)
```

`@solution`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI per visit
explore_framingham %>% 
    count(followup_visit_number, prevalent_mi)
```

`@sct`
```{r}
success_msg("Amazing!")
```

***

```yaml
type: NormalExercise
key: f2ddfd6578
xp: 35
```

`@instructions`
- Lastly, do the same thing but for `prevalent_chd`.

`@hint`
- Use the same syntax as for the `prevalent_mi` code.

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI per visit
explore_framingham %>% 
    count(followup_visit_number, prevalent_mi)

# Count prevalent cases of CHD per visit
explore_framingham %>% 
    count(___, ___)
```

`@solution`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI per visit
explore_framingham %>% 
    count(followup_visit_number, prevalent_mi)

# Count prevalent cases of CHD per visit
explore_framingham %>% 
    count(followup_visit_number, prevalent_chd)
```

`@sct`
```{r}
success_msg("Woohoo! Nice job. You now know how to count the number of cases by visit.")
```

---

## Remove prevalent cases at the baseline

```yaml
type: NormalExercise
key: 25d9449073
xp: 100
```

From the previous exercise, we know that there are prevalent cases of cardiovascular events at the first visit. Prevalent cases of disease at the recruitment visit can introduce bias, so we need to remove these cases before continuing with any further analyses.

`@instructions`
- Exclude (with `!`) observations where `followup_visit_number` is equal to 1 *and* where `prevalent_chd` is equal to 1.
- Count the number of cases by visit to confirm that they have been dropped.

`@hint`
- Filtering logic has the form `variable == condition`, for instance `followup_visit_number == 1`.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
explore_framingham <- framingham %>%
    rename(
        got_cvd = cvd, 
        total_cholesterol = totchol,
        body_mass_index = bmi,
        participant_age = age,
        currently_smokes = cursmoke,
        followup_visit_number = period,
        prevalent_chd = prevchd,
        prevalent_mi = prevmi
    )
```

`@sample_code`
```{r}
# Drop prevalent chd cases from first visit
no_prevalent_cases <- explore_framingham %>% 
    filter(!(___ == ___ & ___ == ___)) 

# Confirm the count of chd cases
no_prevalent_cases %>% 
    count(___, ___) 
```

`@solution`
```{r}
# Drop prevalent chd cases from first visit
no_prevalent_cases <- explore_framingham %>% 
    filter(!(followup_visit_number == 1 & prevalent_chd == 1)) 

# Confirm the count of chd cases
no_prevalent_cases %>% 
    count(followup_visit_number, prevalent_chd) 
```

`@sct`
```{r}
success_msg("Excellent! You've dropped baseline prevalent cases of CHD and started making sure that you've reduced bias in the final results!")
```
