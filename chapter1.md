---
title: "Introduction to cohorts and to analyzing them"
description: "In this chapter we will introduce what a cohort is, how to approach analyzing it, and some first steps in exploring cohort datasets."

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
## Identify the cohort study

```yaml
type: PureMultipleChoiceExercise
xp: 50
skills: 1
key: 6a414dfc25
```

Usually the study design is explicitly stated in the study protocols, however, it can be sometimes tricky to determine if a study is a cohort and what type it is. Here are a couple examples of studies. Which study is a cohort study?

`@possible_answers`

- Researchers use data from insurance companies with medication use, diagnoses, and hospital visits to find out possible side effects of drugs.
- All persons from a clinic who were diagnosed with a disease were recruited into a study. From the general public, another group was recruited as a matching control.
- [Over a one month period, all newborns in a hospital are recruited into a study and followed over time for health complications.]
- In a city, researchers advertised for a study for individuals who have symptoms of a disease. Individuals come in for a single visit to have data collected.
- None of the above

`@hint`

- Do the participants in all the studies share a "common" feature?
- A cohort study should have a time component to it.

`@feedback`

- Incorrect. This could almost be viewed as a cohort because of the common use of an insurance company, except that individuals weren't followed over time, not all had a disease, and all data analysis was done retrospectively data that was already collected. This is an example of "registry-based" type study.
- Incorrect. While this may seem like it could be a "retrospective" cohort, the key feature is the "matched controls", which indicates that this is case-control study.
- Correct! This study is a prospective cohort because the newborns were all born around the same time in the same hospital and did not have any diseases when included in the study.
- Incorrect. But the key feature here is the single time point. Cohorts include multiple time points. This is considered a cross-sectional study.
- Incorrect. One of them is a cohort study design.

---
## What makes it a cohort?

```yaml
type: MultipleChoiceExercise
lang: r
xp: 25
skills: 1
key: ed0789164c
```

We will be using the Framingham Heart Study dataset for this course. The next
few exercises will get you more familiar with the dataset and thinking
more about cohorts.

First, some background. The Framingham study was set up to study what might
might influence the risk of cardiovascular disease (CVD). People from
Framingham, USA were recruited and followed over time. Data was collected on
"risk factors" and CVD every few years.

What makes Framingham a cohort? The `framingham` dataset is loaded for you to
explore. The dataset has yet to be fully tidied, which we will do more in
Chapter 2.

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
type: MultipleChoiceExercise
lang: r
xp: 25
skills: 1
key: bb64056fa8
```

What cohort study design is the Framingam study? You should be able to determine the type based on the variables and the data structure in the `framingham` dataset.

`@instructions`

- Prospective.
- Retrospective.
- Neither.

`@hint`

- Is there a time column in the dataset?
- Did the participants have the disease when the study started?

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
```

`@sct`
```{r}
msg1 <- "Correct! That's because there is a time component and the participants don't have the disease yet."
msg2 <- "Incorrect. Only if the participants already had the disease would it be a retrospective cohort."
msg3 <- "Incorrect. It has to be one of the designs."
test_mc(1, feedback_msgs = c(msg1, msg2, msg3))
```

---
## What would make it a retrospective cohort?

```yaml
type: PureMultipleChoiceExercise
xp: 50
skills: 1
key: 990cfedfbe
```

As you learned in the video lesson, there are some key differences between retrospective and prospective cohort study designs. How could the Framingham study have been designed to be retrospective?

`@possible_answers`

- [At the start of the study, data are obtained from surveys of their past habits, previously stored blood samples/results, and past hospital records, and those who got heart disease are compared to those who didn't.]
- After a number of years in the study, Framingham participants who didn't get heart disease were excluded from the study. Analysis was done on the data that was collected over time and on those with the disease.
- At the start of the study, blood samples are taken and surveys are completed. Those who have the disease are compared to those without by analyzing this data.

`@hint`

A key difference between prospective and retrospective is *when* the study and analysis starts relative to disease status.

`@feedback`

- Correct! The key here is that at the start of the study, those with the disease and those without are compared using data *from the past*.
- Incorrect. In this case, the participants have already been followed for some years, which still means it is a prospective cohort. Dropping those without the disease from the analysis is actually very bad practice.
- Incorrect. The data are collected and analyzed at only one time point, therefore there is no time component.

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
## Which variables are the outcomes and exposures?

```yaml
type: PureMultipleChoiceExercise
xp: 50
skills: 1
key: 38894646ce
```

Which of these answers has the correct variables as the outcome and some potential exposures/predictors?

`@possible_answers`

- Outcome = Body Mass (`bmi`); Exposure = Cholesterol (`totchol`), cardiovascular disease (`cvd`), smoking (`cursmoke`)
- [Outcome = Cardiovascular disease (`cvd`); Exposure = Cholesterol (`totchol`), smoking (`cursmoke`), body mass (`bmi`)]
- Outcome = Cardiovascular disease (`cvd`); Exposure = Time (`time`), cholesterol (`totchol`), sex (`sex`)
- Outcome = Smoking (`cursmoke`); Exposure = Cholesterol (`totchol`), educational attainment (`educ`), age of participant (`age`)

`@hint`

`@feedback`

- Incorrect. The outcome should not be a predictor and the disease should not be an exposure (in this case).
- Correct! The outcome is a disease, and the exposures are possible exposures/predictors.
- Incorrect. This is almost the right answer, except for time. Technically, time is not an exposure, it is just a variable that tells us the visit time.
- Incorrect. Smoking is not the outcome, as it is not a disease.

---
## Select the outcome and exposures

```yaml
type: NormalExercise
key: 98e9f6d5d6
lang: r
xp: 100
skills: 1
```

You need to know which variables are which for the analysis. Usually, it's
fairly easy to identify the outcome. However, knowing which are potential
predictors can be tricky, as modern cohorts often have massive amounts of data
on each participant. Many variables are collected for checking the data, to
aggregate or summarize, or to use as "confounders" (discussed more in later
chapters).

Initially, it can be helpful to keep only variables of interest. For now, let's
select interesting variables to explore them more. At the same time, let's
rename the variables so they are more descriptive.

`@instructions`

- Use `names()` to find the exact name of the variables, then `select` and renaming them all to be more descriptive.
- Choose the correct outcome for cardiovascular disease (CVD). Rename it to `got_cvd`.
- Select four predictors: total cholesterol, body mass index, participant age, and currently smokes.
- There are also several time points, so we need to also select time (`period`). Rename it to `followup_visit_number`.

`@hint`

- Try using `cvd` as the outcome. Try using `totchol` and `bmi` as the original names in the dataset.
- For renaming, replace all spaces with `_` of the variables stated in the instructions.

`@pre_exercise_code`
```{r}
library(dplyr)
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
```

`@sample_code`
```{r}
# Select the potential exposures as well as the main outcome for the framingham
# dataset. Note: while there are two time variables, for now choose `period`
explore_framingham <- framingham %>%
    select(
        # old_variable_name = new_variable_name
        _____ = _____, # outcome variable
        total_cholesterol = _____,
        body_mass_index = _____,
        _____ = age,
        _____ = cursmoke,
        _____ = _____ # visit number
    )
explore_framingham
```

`@solution`
```{r}
# Select the potential exposures as well as the main outcome for the framingham
# dataset. Note: while there are two time variables, for now choose `period`
explore_framingham <- framingham %>%
    select(
        # Format: old_variable_name = new_variable_name
        got_cvd = cvd, # outcome variable
        total_cholesterol = totchol,
        body_mass_index = bmi,
        participant_age = age,
        currently_smokes = cursmoke,
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
type: TabExercise
key: 45b64907b1
lang: r
xp: 100
```

Like the majority of data analyses, a large part of the work involves wrangling
the data into the appropriate form to then analyze. One common technique
involved in data processing and in data exploration and checking is the
"split-apply-combine" method. For exploration, particularly of cohort datasets
with multiple time points, it's useful see how multiple variables change over
time using simple summary statistics.

In this case, since we not only have time as a column, but also multiple
variables to summarize, we'll need to convert the data into a very long format

It is expected that you are familiar with data wrangling in the tidyverse, since
you will need to use the functions from the dplyr and tidyr packages.

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

### Convert to very long format

```yaml
type: NormalExercise
xp: 100
key: 85e4b0de64
```

Convert to the very long data format, so that only four columns are kept in the data frame.

`@instructions`

- Using the tidyr `gather` function, make two new columns `variables` and `values`, but exclude
`followup_visit_number` and `got_cvd`.
- Make sure to only have four columns at the end.

`@solution`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd)
```

`@hint`

- Did you use the `-` to exclude `followup_visit_number` and `got_cvd`?

`@sct`
```{r}
success_msg("Great job! `gather` is a very powerful function to converting to long form.")
```

***

### Calculate the mean by followup and CVD status

```yaml
type: NormalExercise
xp: 100
key: 9ca4b15cf5
```

Calculate the mean of each variable by followup number and CVD status.

`@instructions`

- `group_by` on followup number, CVD status, and the variables.
- Use the dplyr `summarize` function to calculate the `mean` and call the new
variable `mean_values`).
- Make sure to use the `na.rm = TRUE` option when calculating the mean.

`@solution`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(Value, na.rm = TRUE))
```

`@hint`

- Did you use `group_by` with `followup_visit_number`, `got_cvd`, and `variables`?
- Don't forget to use `na.rm = TRUE` with `mean`.
- Did you name the new summarized variables `mean_values`?

`@sct`
```{r}
success_msg("Great job! Combining `gather`, `group_by`, and another function such as `summarize` is a powerful approach to 'split-apply-combine' analyses.")
```

***

### Spread values across to compare those with and without CVD

```yaml
type: NormalExercise
xp: 100
key: 61e6dcd04b
```

Lastly, let's convert back to wide form so we can more easily compare the mean
values of variables for those with and without CVD.

`@instructions`

- Use the tidyr `spread` function to have CVD status (the key) as the new column
headers, and the the mean values (the value) as the values in the new columns.

`@solution`
```{r}
explore_framingham %>% 
    gather(variables, values, -followup_visit_number, -got_cvd) %>% 
    group_by(followup_visit_number, got_cvd, variables) %>% 
    summarize(mean_values = mean(values, na.rm = TRUE)) %>% 
    spread(got_cvd, mean_values)
```

`@hint`

- Use `got_cvd` as the key argument and `mean_values` as the values argument.

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

Because the Framingham study is a prospective cohort, with certain limits to the
data, and with three data collection visits, there are limits to the questions we
can ask and answer. Choose the most valid and most appropriate question that we
could ask from Framingham.

The unchanged `framingham` dataset has been loaded in case you want to look 
through it.

`@instructions`

- Does higher cholesterol cause cardiovascular disease (CVD)?
- Will lower body mass during adolescence increase the risk for CVD?
- Does smoking increase the risk for CVD?
- Does having many close friends lower the risk for CVD?
- All of the above.

`@hint`


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
type: NormalExercise
key: d3caf4d108
lang: r
xp: 100
skills: 1
```

One of the first things to explore is the number of cases, as this will help
inform what you can ask of the data and how to analyze it. Remember, for
longitudinal data, you need to count by the time period, as each participant
could have several rows per collection wave.

Next, count the number of cases and non-cases for prevalent myocardial infarction
(MI, aka heart attack) and coronary heart disease (CHD) at each visit. Both
dplyr and tidyr have been loaded.

`@instructions`

- Count the number of participants (i.e. rows) for each `followup_visit_number`.
- Then, count the number of cases of `prevmi` and `prevchd` for each `followup_visit_number`.
- You will need to use a similar `gather`-`spread` strategy as in a previous exercise.
- For the `gather`, name key "Disease". In `gather` you will also need to specify the columns to gather by (`prevmi` and `prevchd`).

`@hint`

- Did you name the new gather key column "Disease"?
- Are you using `spread` and `gather` properly and in the right order?

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
# All the variables are back in `explore_framingham`, but the renamed are kept.

# Count the number of participants per visit.
explore_framingham %>% 
    count(_____)

# Count the number of prevalent cases of MI and CHD per visit. Use the steps
# like in the previous exercise with gather-spread so cases are columns
explore_framingham %>% 
    _____(_____, Cases, _____, _____) %>% 
    count(followup_visit_number, _____, Cases) %>% 
    _____(Cases, n)
```

`@solution`
```{r}
# All the variables are back in `explore_framingham`, but the renamed are kept.

# Count the number of participants per visit.
explore_framingham %>% 
    count(followup_visit_number)

# Count the number of prevalent cases of MI and CHD per visit. Use the steps
# like in the previous exercise with gather-spread so cases are columns
explore_framingham %>% 
    gather(Disease, Cases, prevmi, prevchd) %>% 
    count(followup_visit_number, Disease, Cases) %>% 
    spread(Cases, n)
```

`@sct`
```{r}
success_msg("Woohoo! Nice job. You now know how to count the number of cases by visit.")
```
