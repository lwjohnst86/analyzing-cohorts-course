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
key: 6a414dfc25
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
- All of the above
- None of the above

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

First, a bit of background. The Framingham study was set up to study what might contribute to the risk for cardiovascular disease. Participants were recruited from the town of Framingham in the United States and followed over time.

What feature makes Framingham a cohort?

If it helps, you can explore the `framingham` dataset in the console. The dataset has not yet been fully tidied, which we will get to in Chapter 2.

`@instructions`
- It studies a disease (cardiovascular disease)
- Participants all came from the town of Framingham
- Participants were followed over time

`@hint`
Cohorts are people who have *something in common*.

`@pre_exercise_code`
```{r}
load("data/framingham.rda")
```

`@sct`
```{r}
msg1 <- "Incorrect. While cohorts often are used to study a disease, this doesn't make it a cohort."
msg2 <- "Correct! Cohorts are people who share a common characteristic. In this case, the participants share a town and so have a similar environment."
msg3 <- "Incorrect. Cohorts always include a time component, but this doesn't make it a cohort."
test_mc(2, feedback_msgs = c(msg1, msg2, msg3))
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

What cohort study design is the Framingam study? You should be able to determine the type based on the variables and the data in the `framingham` dataset.

`@instructions`

- Prospective
- Retrospective

`@hint`

- Is there a time column in the dataset?
- Did the participants have the disease when the study started?

`@pre_exercise_code`
```{r}
load("data/framingham.rda")
```

`@sct`
```{r}
msg1 <- "Correct! That's because there is a time component and the participants don't have the disease yet."
msg2 <- "Incorrect. Only if the participants already had the disease would it be a retrospective cohort."
test_mc(1, feedback_msgs = c(msg1, msg2))
```

----
## What would make it a retrospective cohort?

```yaml
type: PureMultipleChoiceExercise
key: 6a414dfc25
xp: 50
skills: 1
```



`@possible_answers`

`@hint`

`@feedback`


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
## Which variables are outcomes and exposures?

```yaml
type: PureMultipleChoiceExercise
key: 6a414dfc25
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

- Incorrect. The outcome should not be a disease and the disease should not be an exposure (in this case)
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
Many of these variables are collected to be used as "confounders" (which we will
discuss more in later chapters) when analyzing the data.

Usually, at least when exploring the data, it's a good idea to just keep only the
variables of interest in the dataset. So, for now, let's select some of the many
variables and restrict later when we've decided on potential research questions.
At the same time, let's rename the variables to names that are more explicit and
descriptive.

We've loaded the dataset as well as the dplyr package.

`@instructions`

- Use `names()` to identify the exact names of the variables of interest.
- First, choose the correct outcome variable for CVD and rename it to `has_cvd`.
- Next, select four exposure/predictor variables from the previous exercise
(total cholesterol, body mass index, and currently smokes) and rename them to be
clearer.

`@hint`

`@pre_exercise_code`
```{r}
library(dplyr)
load("datasets/framingham.rda")
load("datasets/dietchd.rda")
```

`@sample_code`
```{r}
# Select the potential exposures from the previous exercise as well as the 
# main outcome for the framingham dataset.
framingham %>%
    select(
        ____ =  ____,
        ____ = total_cholesterol,
        ____ = body_mass_index,
        cursmoke =  _____
    )
```

`@solution`
```{r}
# Select the potential exposures from the previous exercise as well as the 
# main outcome for the framingham dataset.
framingham %>%
    select(
        cvd = has_cvd,
        totchol = total_cholesterol,
        bmi  = body_mass_index,
        cursmoke =  currently_smokes
    )
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
the data into the appropriate form to then analyze. One common technique involved
in data processing and in data exploration and checking is the "split-apply-combine"
method. For exploration, particularly of cohort datasets with multiple time points,
it's useful see how multiple variables change over time using simple summary statistics. 

In this case, since we have no only time as a column, but also multiple variables to 
summarize, we'll need to convert the data into a very long format

It is expected that you are familiar with data wrangling in the tidyverse, since
you will need to use the functions from the dplyr and tidyr packages.


`@pre_exercise_code`
```{r}
library(dplyr)
library(tidyr)
load("datasets/framingham.rda")
load("datasets/dietchd.rda")
```

`@sample_code`
```{r}
framingham  %>% 

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
`time` and `cvd`.
- Make sure to only have four columns at the end.

`@solution`
```{r}
framingham %>% 
    gather(Measure, Value, -time, -cvd)
```

`@hint`

- Did you use the `-` to exclude `time` and `cvd`?

`@sct`
```{r}

```

***

### Calculate summary statistics by time and cvd

```yaml
type: NormalExercise
xp: 100
key: 9ca4b15cf5
```

Calculate the mean and the standard deviation 

`@instructions`

`@solution`
```{r}
framingham %>% 
    # TODO: choose other variables.
    gather(Measure, Value, totchol, hdlc, bmi, age) %>% 
    group_by(period, cvd, Measure) %>% 
    summarize(Mean = round(mean(Value, na.rm = TRUE), 2),
              SD = round(sd(Value, na.rm = TRUE), 2)
    ) %>% 
    spread(cvd, MeanS)
```

`@hint`

- Did you use `group_by` with `time`, `cvd`, and `variables`?
- Don't forget to use `na.rm = TRUE` with `mean` and `sd`.

`@sct`
```{r}

```

***

### Sub Heading 2

```yaml
type: NormalExercise
xp: 100
key: 61e6dcd04b
```

`@instructions`

`@solution`
```{r}
framingham %>% 
    # TODO: choose other variables.
    gather(Measure, Value, totchol, hdlc, bmi, age) %>% 
    group_by(period, cvd, Measure) %>% 
    summarize(Mean = round(mean(Value, na.rm = TRUE), 2),
              SD = round(sd(Value, na.rm = TRUE), 2)
    ) %>% 
    spread(cvd, MeanS)
```

`@hint`

`@sct`
```{r}

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

