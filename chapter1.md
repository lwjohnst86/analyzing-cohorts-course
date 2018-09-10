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

The Framingham study was set up to study what might might influence the risk of cardiovascular disease (CVD). People from Framingham, USA were recruited and followed over time. Data was collected on "risk factors" and CVD every few years.

What makes Framingham a cohort? The `framingham` dataset is loaded for you to explore. The dataset has yet to be fully tidied, which we will do more in Chapter 2.

`@instructions`
- It studies a disease (CVD).
- Participants all came from the town of Framingham, USA.
- Participants were followed over time.
- Participants had "risk factors" measured.

`@hint`
Cohorts are people who have *something in common*.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
```

`@sct`
```{r}
msg1 <- "Incorrect. While cohorts often are used to study a disease, this doesn't make it a cohort."
msg2 <- "Correct! Cohorts are people who share a common characteristic. In this case, the participants share a town and so have a similar environment."
msg3 <- "Incorrect. While cohorts always include a time component, this alone doesn't make it a cohort."
msg4 <- "Incorrect. While all cohorts have risk factors measured, this alone doesn't make it a cohort."
test_mc(2, feedback_msgs = c(msg1, msg2, msg3, msg4))
```

---

## What cohort type is the Framingham Heart Study?

```yaml
type: NormalExercise
key: bb64056fa8
lang: r
xp: 100
skills: 1
```

Usually you can determine the cohort design from the variables in the dataset. What cohort study design is the Framingam study, based on the variables?

`@instructions`
- Take a look through the `framingham` dataset.
- Select the two variables that indicate the cohort design.
- Write in the text what the cohort type is: either "prospective" or "retrospective".

`@hint`
- The first column should be `time`. While there is also another column for time (`period`), you don't need to select this one for this exercise.
- Recall that Framingham was designed to study the disease `cvd`.
- The cohort type should be in lower case.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
```

`@sample_code`
```{r}
# Two columns indicating design
framingham %>% 
    select(_____, _____)

# Study design
"_____"
```

`@solution`
```{r}
# Two columns indicating design
framingham %>% 
    select(time, cvd)

# Study design
"prospective"
```

`@sct`
```{r}
success_msg("Yes! You've identified that Framingham is a prospective cohort!")
```

---

## Cohort types and introducing the dataset

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

You need to know which variables are which for the analysis. Usually, it's fairly easy to identify the outcome. However, knowing which are potential predictors can be tricky, as modern cohorts often have massive amounts of data on each participant. Many variables are collected for checking the data, to aggregate or summarize, or to use as "confounders" (discussed more in later chapters).

Initially, it can be helpful to keep only variables of interest. For now, let's select interesting variables to explore them more. At the same time, let's rename the variables so they are more descriptive.

`@instructions`
- Use `names()` to find the exact name of the variables, then `select` and renaming them all to be more descriptive.
- Choose the correct outcome for cardiovascular disease (CVD). Rename it to `got_cvd`.
- Select four predictors: total cholesterol, body mass index, participant age, and currently smokes.
- There are also several time points, so we need to also select time (`period`). Rename it to `followup_visit_number`.

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
# Select the potential exposures as well as the main outcome for the framingham
# dataset.
explore_framingham <- framingham %>%
    select(
        # Format: old_variable_name = new_variable_name
        _____ = _____, # outcome variable
        total_cholesterol = _____,
        body_mass_index = _____,
        _____ = age,
        _____ = cursmoke,
        _____ = period # visit number
    )
explore_framingham
```

`@solution`
```{r}
# Select the potential exposures as well as the main outcome for the framingham
# dataset.
explore_framingham <- framingham %>%
    select(
        # Format: old_variable_name = new_variable_name
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

Like the majority of data analyses, a large part of the work involves wrangling the data into the appropriate form to then analyze. One common technique involved in data processing and in data exploration and checking is the "split-apply-combine" method. For exploration, particularly of cohort datasets with multiple time points, it's useful see how multiple variables change over time using simple summary statistics.

In this case, since we not only have time as a column, but also multiple variables to summarize, we'll need to convert the data into a very long format

It is expected that you are familiar with data wrangling in the tidyverse, since you will need to use the functions from the dplyr and tidyr packages.

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
explore_framingham  %>%
```

***

```yaml
type: NormalExercise
key: 85e4b0de64
xp: 35
```



`@instructions`
- Using the tidyr `gather` function, make two new columns `variables` and `values`, but exclude
`followup_visit_number` and `got_cvd`.
- Make sure to only have four columns at the end.

`@hint`
- Use the `-` to exclude `followup_visit_number` and `got_cvd`.

`@sample_code`
```{r}
explore_framingham  %>%
```

`@solution`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd)
```

`@sct`
```{r}
success_msg("Great job! `gather` is a very powerful function to converting to long form.")
```

***

```yaml
type: NormalExercise
key: 9ca4b15cf5
xp: 35
```



`@instructions`
- `group_by` on followup number, CVD status, and the variables.
- Use the dplyr `summarize` function to calculate the `mean` and call the new variable `mean_values`).
- Make sure to use the `na.rm = TRUE` option when calculating the mean.

`@hint`
- Use `group_by` with `followup_visit_number`, `got_cvd`, and `variables`.
- Use `na.rm = TRUE` with `mean`.
- Name the new summarized variable `mean_values`.

`@sample_code`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>%
```

`@solution`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(Value, na.rm = TRUE))
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
- Use the tidyr `spread` function to have CVD status (the key) as the new column headers, and the the mean values (the value) as the values in the new columns.

`@hint`
- Use `got_cvd` as the key argument.

`@sample_code`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(values, na.rm = TRUE)) %>%
```

`@solution`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(values, na.rm = TRUE)) %>% 
    spread(got_cvd, mean_values)
```

`@sct`
```{r}
success_msg("Awesome! You did it. You now have can compare between those who didn't and those who did get CVD.")
```

---

## Questions and answers we can get from cohorts

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

## What questions can be asked from Framingham?

```yaml
type: MultipleChoiceExercise
key: d7e39ba425
lang: r
xp: 50
skills: 1
```

Because the Framingham study is a prospective cohort, with certain limits to the data, and with three data collection visits, there are limits to the questions we can ask and answer. Choose the most valid and most appropriate question that we could ask from Framingham.

The unchanged `framingham` dataset has been loaded in case you want to look  through it.

`@instructions`
- Does higher cholesterol cause cardiovascular disease (CVD)?
- Will lower body mass during adolescence increase the risk for CVD?
- Does smoking increase the risk for CVD?
- Does having many close friends lower the risk for CVD?
- All of the above.

`@hint`
- Remember, these are questions to ask *of the Framingham study*... the variables in the question must exist in the dataset.
- We cannot directly determine "causes" from cohort studies.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
```

`@sct`
```{r}
msg1 <- "Incorrect. The cohort study was not designed to answer 'causes'."
msg2 <- "Incorrect. While cohorts could answer this questions, Framingham participants are all in middle age so we can't answer questions outside of that timeframe."
msg3 <- "Correct! The Framingham dataset collected information on smoking status and can assess relative risk between exposure status."
msg4 <- "Incorrect. While cohorts could answer this question, the Framingham Study did not collect this information."
msg5 <- "Incorrect. One of the above is a valid question."
test_mc(3, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```

---

## Count number of participants and cases per visit

```yaml
type: TabExercise
key: 2ba20dff0f
xp: 100
```

One of the first things to explore is the number of cases, as this will help inform what you can ask of the data and how to analyze it. Remember, for longitudinal data, you need to count by the time period, as each participant could have several rows per collection wave.

Next, count the number of cases and non-cases for prevalent myocardial infarction (MI, aka heart attack) and coronary heart disease (CHD) at each visit. Both dplyr and tidyr have been loaded and all variables have been added back into `explore_framingham`.

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
        followup_visit_number = period
    )
```

`@sample_code`
```{r}
# Count the number of participants per visit.
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
# Count the number of participants per visit.
explore_framingham %>%
```

`@solution`
```{r}
# Count the number of participants per visit.
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
- Use `gather`, with key as "Disease" and value as "Cases". Gather only the two disease columns.

`@hint`
- Gather the correct disease columns as written in the instructions.
- Name the new gather key column "Disease" and the value column "Cases".

`@sample_code`
```{r}
# Count the number of participants per visit.
explore_framingham %>% 
    count(followup_visit_number)

# Count the number of prevalent cases of MI and CHD per visit. 
explore_framingham %>%
```

`@solution`
```{r}
# Count the number of participants per visit.
explore_framingham %>% 
    count(followup_visit_number)

# Count the number of prevalent cases of MI and CHD per visit. 
explore_framingham %>% 
    gather(Disease, Cases, prevmi, prevchd)
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
- Next we need to count the number of `Cases` by `Disease` and visit number (`followup_visit_number`).

`@hint`
- Use the `count` function with three variables.

`@sample_code`
```{r}
# Count the number of participants per visit.
explore_framingham %>% 
    count(followup_visit_number)

# Count the number of prevalent cases of MI and CHD per visit. 
explore_framingham %>% 
    gather(Disease, Cases, prevmi, prevchd) %>%
```

`@solution`
```{r}
# Count the number of participants per visit.
explore_framingham %>% 
    count(followup_visit_number)

# Count the number of prevalent cases of MI and CHD per visit. 
explore_framingham %>% 
    gather(Disease, Cases, prevmi, prevchd) %>% 
    count(followup_visit_number, Disease, Cases)
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
- Lastly, you need to `spread` the data so `Cases` are columns, with their corresponding count.

`@hint`
- The variable `n` should be the values in the spread columns.

`@sample_code`
```{r}
# Count the number of participants per visit.
explore_framingham %>% 
    count(followup_visit_number)

# Count the number of prevalent cases of MI and CHD per visit. 
explore_framingham %>% 
    gather(Disease, Cases, prevmi, prevchd) %>% 
    count(followup_visit_number, Disease, Cases) %>%
```

`@solution`
```{r}
# Count the number of participants per visit.
explore_framingham %>% 
    count(followup_visit_number)

# Count the number of prevalent cases of MI and CHD per visit. 
explore_framingham %>% 
    gather(Disease, Cases, prevmi, prevchd) %>% 
    count(followup_visit_number, Disease, Cases) %>% 
    spread(Cases, n)
```

`@sct`
```{r}
success_msg("Woohoo! Nice job. You now know how to count the number of cases by visit.")
```
