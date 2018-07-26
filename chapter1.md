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

First, a bit of background. The Framingham study was set up to study what might contribute to the risk for cardiovascular disease. Participants were recruited from the town of Framingham and followed over time.

What feature makes Framingham a cohort?

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

What cohort study design is the Framingam study?

`@instructions`
- Prospective
- Retrospective

`@hint`

`@pre_exercise_code`
```{r}
load("data/framingham.rda")
```

`@sct`
```{r}
msg1 <- "Correct! "
msg2 <- "Incorrect. "
test_mc(2, feedback_msgs = c(msg1, msg2))
```


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

`@hint`

`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```

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
## Analytic and interpretation limitations of each study design

```yaml
type: MultipleChoiceExercise
key: d7e39ba425
lang: r
xp: 50
skills: 1
```


`@instructions`

`@hint`

`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```

---
## Extract outcome and exposures of interest from the datasets

```yaml
type: NormalExercise
key: 98e9f6d5d6
lang: r
xp: 100
skills: 1
```

{{TabExercise? with NE}}
It's important to recognize which are outcome variables and which are the
predictors/exposures of interest. Often cohort studies have massive numbers of
variables that have been measured, so to make it easier to explore and analyze
the data, let's subset out the variables of interest. For now, let's select many
variables and restrict later when we've decided on potential research questions.
At the same time, let's rename the variables to names that are more explicit and
descriptive.

We've loaded the dataset as well as the dplyr package.

`@instructions`

- Using `names()`, identify which variables are the appropriate {{...}}
- First, choose the correct outcome variable for CVD and rename it to `has_cvd`.
- Next, select four predictor variables and rename them to be clearer {{make clear here?}}

`@hint`

`@pre_exercise_code`
```{r}
library(dplyr)
load("datasets/framingham.rda")
load("datasets/dietchd.rda")
```

`@sample_code`
```{r}
# Select several potential exposures and the main outcome for both datasets
framingham %>% 
    select(____ = ____, ____ = total_cholesterol, ____ = body_mass_index, {{...}} )

dietchd %>% 
    select(chd, y, energy, fat, fibre)
```

`@solution`
```{r}
# NOTE: Need to make the answer be slightly fluid since different exposures
# could be chosen. But need to make sure that only specific exposures are
# chosen.

# Select several potential exposures and the main outcome for both datasets
framingham %>% 
    select(cvd, totchol, bmi, hdlc)

dietchd %>% 
    select(chd, y, energy, fat, fibre)
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

`@hint`

`@pre_exercise_code`
```{r}
library(dplyr)
load("datasets/framingham.rda")
load("datasets/dietchd.rda")
```

`@sample_code`
```{r}

```

`@solution`
```{r}
framingham %>% 
    count(period, cvd)

dietchd %>% 
    count(chd)
```

`@sct`
```{r}

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

