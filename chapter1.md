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

## An exercise title written in sentence case

```yaml
type: NormalExercise
lang: r
xp: 100
skills: 1
key: 6b81b446b5
```

This is the assignment text. It should help provide students with the background information needed.
The instructions that follow should be in bullet point form with clear guidance for what is expected.

`@instructions`
- Instruction 1
- Instruction 2
- Instruction 3
- Instruction 4

`@hint`
- Here is the hint for this setup problem. 
- It should get students 50% of the way to the correct answer.
- So don't provide the answer, but don't just reiterate the instructions.
- Typically one hint per instruction is a sensible amount.

`@pre_exercise_code`

```{r}
# Load datasets and packages here.
download.file("https://assets.datacamp.com/production/repositories/2079/datasets/b0b1f5c64a8ae3de0913eff20c0ec55749b5f9f5/framingham.rda", "framingham.rda")
load("framingham.rda")
```

`@sample_code`

```{r}
# Your
# sample
# code
# should
# be
# ideally
# 10 lines or less,
# with a max
# of 16 lines.
```

`@solution`

```{r}
# Answer goes here
# Make sure to match the comments with your sample code
# to help students see the differences from solution
# to given.
# Paste here first
```

`@sct`

```{r}
# Update this to something more informative.
success_msg("Some praise! Then reinforce a learning objective from the exercise.")
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
## Another Exercise

```yaml
type: NormalExercise
key: 3fe61c079b
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
