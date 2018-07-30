---
title: "Introduction to cohorts and to analyzing them"
description: "In this chapter we will introduce what a cohort is, how to approach analyzing it, and some first steps in exploring cohort datasets."

---
## Introduction to Cohort Studies

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
## Identify if the study is a cohort and what type it is

```yaml
type: PureMultipleChoiceExercise
xp: 50
skills: 1
```

Usually the study design is explicitly stated in the study protocols, however, it can be sometimes tricky to determine if a study is a cohort and what type it is. Here are a couple examples of studies. Which study is a cohort study?

`@possible_answers`

- Researchers use data from insurance companies with medication use, diagnoses, and hospital visits to find out possible side effects of drugs.
- All persons from a clinic who were diagnosed with a disease were recruited into a study. From the general public, another group was recruited as a matching control.
- [Over a one month period, all newborns in a hospital are recruited into a study and followed over time for health complications.]
- In a city, researchers advertised for a study for individuals who have symptoms of a disease. Individuals come in for a single visit to have data collected.
- All of the above
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

For this course we will be using the Framingham Heart Study to learn about the process of analysing cohort datasets. These next few exercises are meant to quickly get you familiar with the dataset and thinking about it in terms of the "cohort" setting. After the next video exercise, we will get into exploring the dataset using R.

First, a bit of background. The Framingham study was set up to study what factors or measures might contribute to the risk for cardiovascular disease. Participants were recruited from the town of Framingham in the United States and followed over time, with data collected on "risk factors" occurring every few years.

What feature makes Framingham a cohort?

If it helps, you can explore the `framingham` dataset in the console. The dataset has not yet been fully tidied, which we will get to more in Chapter 2.

`@instructions`

- It studies a disease (cardiovascular disease).
- Participants all came from the town of Framingham.
- Participants were followed over time.
- Participants had "risk factors" measured.

`@hint`

Cohorts are people who have *something in common*.

`@pre_exercise_code`
```{r}
load("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda")
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

`@hint`

- Is there a time column in the dataset?
- Did the participants have the disease when the study started?

`@pre_exercise_code`
```{r}
load("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda")
```

`@sct`
```{r}
msg1 <- "Correct! That's because there is a time component and the participants don't have the disease yet."
msg2 <- "Incorrect. Only if the participants already had the disease would it be a retrospective cohort."
test_mc(1, feedback_msgs = c(msg1, msg2))
```

---
## What would make it a retrospective cohort?

```yaml
type: PureMultipleChoiceExercise
xp: 50
skills: 1
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
## Introduction to the datasets and exploring them

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
## Which variables are outcomes and which are exposures?

```yaml
type: PureMultipleChoiceExercise
xp: 50
skills: 1
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
## Extract the outcome and exposures of interest from the Framingham dataset

```yaml
type: NormalExercise
key: 98e9f6d5d6
lang: r
xp: 100
skills: 1
```

It's important to recognize which are outcome variables and which are the
predictors/exposures of interest. 

It's usually pretty easy to identify which variable is the outcome. However,
determining which variables are the potential exposures/predictors can be a bit
more tricky, as modern cohort studies have massive amounts of data collected on
each participant... meaning there are easily hundreds of variables in a dataset.
Many of these variables are collected to be used as "confounders" when analyzing
the data. We will discuss confounders more in later chapters.

Usually, at least when exploring the data, it's a good idea to just keep only the
variables of interest in the dataset. So, for now, let's select some of the many
variables and restrict later when we've decided on potential research questions.
At the same time, let's rename the variables to names that are more explicit and
descriptive.

We've loaded the dataset as well as the dplyr package.

`@instructions`

- Use `names()` to identify the exact names of the variables of interest.
- Use the dplyr way of `select`ing and renaming in one function.
- First, choose the correct outcome variable for cardiovascular disease (CVD)
and rename it to `got_cvd`.
- Next, select four exposure/predictor variables from the previous exercise
(total cholesterol, body mass index, participant age, and currently smokes) and
rename the variables to be clearer and more explicit about what they represent.
- Lastly, since this dataset has multiple time points, we will need to include
time in the new dataset. Select `period` and rename to `followup_visit_number`. 
(Note: the `time` variable is days since first visit and is more important in 
later analyses, but for now `period` is easier for exploratory analyses.)

`@hint`

- Try using `cvd` as the outcome. Try using `totchol` and `bmi` as the original names in the dataset.
- For renaming, replace all spaces with `_` of the variables stated in the instructions.

`@pre_exercise_code`
```{r}
library(dplyr)
load("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda")
```

`@sample_code`
```{r}
# Select the potential exposures from the previous exercise as well as the 
# main outcome for the framingham dataset.
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
# Select the potential exposures from the previous exercise as well as the 
# main outcome for the framingham dataset.
explore_framingham <- framingham %>%
    select(
        # old_variable_name = new_variable_name
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
## Exploring simple summaries of the exposures by outcome

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
load("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda")
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

### Calculate summary statistics by followup and CVD status

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
## Scientific questions that can be asked of cohort data

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
## When can prevalence or incidence be calculated?

```yaml
type: MultipleChoiceExercise
key: 79c8ccd360
lang: r
xp: 50
skills: 1
```
{{Convert to BulletExercise?}}

`@instructions`

{{placeholder}}

`@hint`

{{placeholder}}

`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```

---
## Calculate number of cases.

```yaml
type: NormalExercise
key: d3caf4d108
lang: r
xp: 100
skills: 1
```

One of the first things to explore is the number of cases, as this will help inform
what you can ask of the data and how to analyze it. Remember, for longitudinal data,
you need to count by the time period, as each participant could have several rows per
collection wave.

`@instructions`

{{placeholder}}

`@hint`

{{placeholder}}

`@pre_exercise_code`
```{r}
library(dplyr)
load("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda")
```

`@sample_code`
```{r}

```

`@solution`
```{r}
framingham %>% 
    count(period, cvd)
```

`@sct`
```{r}

```

---
## Analytic and interpretation limitations of each study design

```yaml
type: MultipleChoiceExercise
key: d7e39ba425
lang: r
xp: 50
skills: 1
```

1. There are some analytic limitations to each study design. 
- MCQ/text: Limitation of retrospective over prospective (from an analytic and
interpretation point of view).
- MCQ/text: General limitations of prospective cohorts (again from analytic or
interpretation view)

`@instructions`

{{placeholder}}

`@hint`

{{placeholder}}

`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```
