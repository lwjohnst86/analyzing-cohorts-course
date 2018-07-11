---
title: "Introduction to cohorts and types of research questions"
description: "In this chapter we will introduce what a cohort is"

---
## Introduction to Cohort Designs

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
## Which is which study type?

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
## When can prevalence or incidence be calculated?

```yaml
type: MultipleChoiceExercise
key: 79c8ccd360
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

