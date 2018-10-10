---
title: 'Introduction to cohorts and to analyzing them'
description: 'In this chapter we will introduce what a cohort is, how to approach analyzing it, and some first steps in exploring cohort datasets.'
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

The Framingham cohort was set up to study what might influence the risk of cardiovascular disease (CVD). People from Framingham, USA were recruited and followed over time. Data was collected on risk factors and CVD outcomes every few years.

What makes the Framingham dataset a cohort? The `framingham` dataset is loaded for you to explore. The dataset has yet to be fully tidied, which we will do more of in Chapter 2.

`@possible_answers`
- It studies a disease (CVD).
- Participants all came from the town of Framingham, USA.
- Participants were followed over time.
- Participants had risk factors measured.

`@hint`
Cohorts are people who have *something in common*.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
framingham$time <- NULL
```

`@sct`
```{r}
msg1 <- "Incorrect. While cohorts often are used to study a disease, this doesn't make it a cohort."
msg2 <- "Correct! Cohorts are people who share a common characteristic. In this case, the participants share a town and so have a similar environment."
msg3 <- "Incorrect. While cohorts always include a time component, this alone doesn't make it a cohort."
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

We expect you to be (at least a bit) familiar with the tidyverse packages and functions, since you will need to use dplyr and tidyr functions throughout this course.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
framingham$time <- NULL

```

`@sample_code`
```{r}
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
- Take a look through the `framingham` dataset.
- Select the two variables that indicate `framingham`'s cohort design.

`@hint`
- Recall that Framingham was designed to study the disease `cvd`.

`@sample_code`
```{r}
# Select two columns that indicate design
framingham %>% 
    select(_____, _____)

```

`@solution`
```{r}
# Select two columns that indicate design
framingham %>% 
    select(period, cvd)

```

`@sct`
```{r}
success_msg("Yes! You've identified the two variables that tell us Framingham's design!")

```

***

```yaml
type: MultipleChoiceExercise
key: c22855322d
xp: 50
```

`@question`
What is the cohort design?

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
success_msg("Nice job! You've identified that Framingham is a prospective cohort design!")
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

You need to know what the variables are, so you can analyze the data. Usually, it's fairly easy to identify the outcome. However, knowing which are potential predictors can be tricky, as modern cohorts often have massive amounts of data on each participant. Many variables are collected for checking the data, to aggregate or to summarize, or to use as "confounders" (discussed more in later chapters).

Initially, it can be helpful to keep only the variables of interest. For now, let's select interesting variables to explore them more. At the same time, let's rename the variables so they are more descriptive.

`@instructions`
- Use `names(framingham)` to find the exact name of the variables, then rename them all to be more descriptive.
- Choose the correct outcome for cardiovascular disease (CVD). Rename it to `got_cvd`.
- Rename the four predictors to `total_cholesterol`, `body_mass_index`, `participant_age`, and `currently_smokes`.
- Rename the visit number column to `followup_visit_number`.

`@hint`
- Confirm the exact original variable names in the dataset.
- For renaming the predictors, replace the spaces with `_` for the variables stated in the instructions.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
```

`@sample_code`
```{r}
# Select and rename the potential exposures and outcome
explore_framingham <- framingham %>%
    select(
        # Format: new_variable_name = old_variable_name
        _____ = _____, # outcome variable
        _____ = totchol,
        _____ = bmi,
        _____ = age,
        _____ = cursmoke,
        _____ = period # visit number
    )
explore_framingham
```

`@solution`
```{r}
# Select and rename the potential exposures and outcome
explore_framingham <- framingham %>%
    select(
        # Format: new_variable_name = old_variable_name
        got_cvd = cvd, # outcome variable
        total_cholesterol = totchol,
        body_mass_index = bmi,
        participant_age = age,
        currently_smokes = cursmoke,
        followup_visit_number = period # visit number
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
type: TabExercise
key: 45b64907b1
lang: r
xp: 100
```

Like the majority of data analyses, a large part of the work involves wrangling the data into the appropriate form to then analyze it. For exploration, particularly of cohort datasets with multiple time points, it's useful see how multiple variables change over time using simple summary statistics.

In this case, since we not only have a time column (`period`), but also multiple variables to summarize, we'll need to convert the data into a very long format.

This exercise makes heavy use of tidyverse-style wrangling, so we expect familiarity with the tidyverse.

`@pre_exercise_code`
```{r}
library(dplyr)
library(tidyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
explore_framingham <- framingham %>%
    select(
        got_cvd = cvd, 
        total_cholesterol = totchol,
        body_mass_index = bmi,
        participant_age = age,
        currently_smokes = cursmoke,
        followup_visit_number = period
    )
```

`@sample_code`
```{r}
# Gather data into long form, but exclude (-) two columns
explore_framingham  %>%
```

***

```yaml
type: NormalExercise
key: 85e4b0de64
xp: 35
```

`@instructions`
- Using the tidyr `gather` function, make two new columns `variables` and `values`, but exclude `followup_visit_number` and `got_cvd`.
- Make sure to only have four columns at the end.

`@hint`
- Use the `-` to exclude `followup_visit_number` and `got_cvd`.

`@sample_code`
```{r}
# Gather data into long form, but exclude (-) two columns
explore_framingham  %>%
```

`@solution`
```{r}
# Gather data into long form, but exclude (-) two columns
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd)
```

`@sct`
```{r}
success_msg("Great job! `gather` is a very powerful function for converting to long form.")
```

***

```yaml
type: NormalExercise
key: 9ca4b15cf5
xp: 35
```

`@instructions`
- Use `group_by` on visit number, CVD status, and the variables.
- Use the dplyr `summarize` function to calculate the `mean` and call the new variable `mean_values`.
- Make sure to use the `na.rm = TRUE` option when calculating the mean.

`@hint`
- Use `group_by` with `followup_visit_number`, `got_cvd`, and `variables`.
- Use `na.rm = TRUE` with `mean`.
- Name the new summarized variable `mean_values`.

`@sample_code`
```{r}
# Group by, then summarise
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>%
```

`@solution`
```{r}
# Group by, then summarise
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(values, na.rm = TRUE))
```

`@sct`
```{r}
success_msg("Great job! Combining `gather`, `group_by`, and another function such as `summarize` is a powerful approach to 'split-apply-combine' analyses.")
```

***

```yaml
type: NormalExercise
key: 61e6dcd04b
xp: 30
```

`@instructions`
- Use the tidyr `spread` function to have CVD status (the key) as the new column headers, and the mean values (the value) as the values in the new columns.

`@hint`
- Use `got_cvd` as the key argument.

`@sample_code`
```{r}
# Spread into wide form
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(values, na.rm = TRUE)) %>%
```

`@solution`
```{r}
# Spread into wide form
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(values, na.rm = TRUE)) %>% 
    spread(got_cvd, mean_values)
```

`@sct`
```{r}
success_msg("Awesome! You did it. You compared those who didn't and those who did get CVD.")
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

One of the first things to explore is the number of cases, as this will help inform what you can ask of the data and how to analyze it. Remember, for longitudinal data, you need to count by the time period, as each participant could have several rows because of multiple collection waves.

Next, count the number of cases and non-cases for prevalent myocardial infarction (MI, aka heart attack; `prevalent_mi`) and coronary heart disease (CHD; `prevalent_chd`) at each visit. Both dplyr and tidyr are loaded and all variables have been added back into `explore_framingham`.

`@pre_exercise_code`
```{r}
library(dplyr)
library(tidyr)
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
# Count number of participants per visit
explore_framingham %>%
```

***

```yaml
type: NormalExercise
key: 69ff80d798
xp: 25
```

`@instructions`
- Count the number of participants (i.e. rows) for each `followup_visit_number`.

`@hint`
- Use the `count` function.

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>%
```

`@solution`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)
```

`@sct`
```{r}
success_msg("Great! You now know how to count the number of participants at each time point.")
```

***

```yaml
type: NormalExercise
key: a0c6bd239b
xp: 25
```

`@instructions`
- Now, we want to count the cases of `prevmi` and `prevchd` for each `followup_visit_number`.
- Use `gather` to create new columns "disease" and "cases" specific to the two diseases.

`@hint`
- Gather the correct disease columns as written in the instructions.
- Name the new gather key column "disease" and the value column "cases".

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI and CHD per visit
explore_framingham %>%
    # First, gather to long form
```

`@solution`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI and CHD per visit
explore_framingham %>% 
    # First, gather to long form
    gather(disease, cases, prevalent_mi, prevalent_chd)
```

`@sct`
```{r}
success_msg("Excellent, now the next step.")
```

***

```yaml
type: NormalExercise
key: 9bfa483cb9
xp: 25
```

`@instructions`
- Next we need to count the number of `cases` by `disease` and by visit number (`followup_visit_number`).

`@hint`
- Use the `count` function with the three variables.

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI and CHD per visit
explore_framingham %>% 
    gather(disease, cases, prevmi, prevchd) %>%
    # Now, count the cases
```

`@solution`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI and CHD per visit
explore_framingham %>% 
    gather(disease, cases, prevalent_mi, prevalent_chd) %>% 
    # Now, count the cases
    count(followup_visit_number, disease, cases)
```

`@sct`
```{r}
success_msg("Nearly there!")
```

***

```yaml
type: NormalExercise
key: 19a1c49e37
xp: 25
```

`@instructions`
- Lastly, you need to `spread` the data so `cases` are columns, with their corresponding count.

`@hint`
- The variable `n` should be the values in the spread columns.

`@sample_code`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI and CHD per visit
explore_framingham %>% 
    gather(disease, cases, prevalent_mi, prevalent_chd) %>% 
    count(followup_visit_number, disease, cases) %>%
    # Spread to wide form
```

`@solution`
```{r}
# Count number of participants per visit
explore_framingham %>% 
    count(followup_visit_number)

# Count prevalent cases of MI and CHD per visit
explore_framingham %>% 
    gather(disease, cases, prevalent_mi, prevalent_chd) %>% 
    count(followup_visit_number, disease, cases) %>% 
    # Spread to wide form
    spread(cases, n)
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

We know there are prevalent cases of cardiovascular events at the first visit. In order to move on to further analyses and exploration, we must remove these prevalent cases so we don't introduce any bias into the results. For now, only drop prevalent cases of coronary heart disease (CHD).

`@instructions`
- Drop all cases of CHD (`1`) at the first (`1`) visit.
- Confirm that these have been dropped by counting the number of cases by visit.

`@hint`
- Filter first prevalent CHD and then followup visit number.
- Count by followup visit and by prevalent CHD.

`@pre_exercise_code`
```{r}
library(dplyr)
library(tidyr)
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
    filter(!(_____ == _____ & _____ == _____)) 

# Confirm the count of chd cases
no_prevalent_cases %>% 
    _____(_____, _____) 
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
success_msg("Excellent! You've dropped baseline prevalent cases of CHD.")
```
