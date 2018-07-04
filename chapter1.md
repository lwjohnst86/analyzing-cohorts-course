---
title: "Introduction to cohorts and types of research questions"
description: This is a template chapter.

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

It's important to recognize which are outcome variables and which are the
predictors/exposures of interest. Often cohort studies have massive numbers of
variables that have been measured, so to make it easier to explore and analyze
the data, need to subset out the variables of interest.

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
# Select several potential exposures and the main outcome for both datasets
framingham %>% 
    select(cvd, totchol, bmi, hdlc)

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


`@instructions`

`@hint`

`@pre_exercise_code`
```{r}

```

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
## Exploring simple summaries of the exposures by outcome

```yaml
type: NormalExercise
key: 8aea115604
lang: r
xp: 100
skills: 1
```


`@instructions`

`@hint`

`@pre_exercise_code`
```{r}

```

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

