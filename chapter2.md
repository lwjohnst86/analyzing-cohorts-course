---
title: 'Data wrangling, exploration, and formatting'
description: ""
---

## Pre-wrangling exploration

```yaml
type: VideoExercise
key: f20c0dcfb8
xp: 50
```

`@projector_key`
146b85090bb8ab77efbfe45c5c751f5d

---

## Visually examine the outcomes with the exposures

```yaml
type: NormalExercise
key: e50ea375f8
xp: 100
```

{{convert to tab exercise}}

Create a simple visual comparing the outcome with the exposures.

`@instructions`


`@hint`


`@pre_exercise_code`
```{r setup}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)

framingham <- framingham %>%
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

```

`@solution`
```{r}
framingham %>% 
    select(time, got_cvd, total_cholesterol, participant_age, body_mass_index,
           currently_smokes) %>% 
    mutate(cvd = as.factor(cvd)) %>% 
    gather(Variable, Value, -time, -cvd) %>% 
    ggplot(aes(x = Value, group = cvd, fill = cvd)) +
    geom_density(alpha = 0.6) +
    facet_grid(~ Variable, scales = "free")
```

`@sct`
```{r}

```

---

## Plot individual (or summary) change over time in longitudinal datasets

```yaml
type: NormalExercise
key: e784da5222
xp: 100
```

Create a line plot (or summary line plot if data too big) by individual.

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

## Inspect graphically all variables of interest individually

```yaml
type: TabExercise
key: aec12c0d13
xp: 100
```

Create a box and jitter plot of all the variables of interest, at the baseline visit:

`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}
fh_long <- framingham %>% 
    filter(time == 0) %>% 
    select(cvd, totchol, bmi, age) %>% 
    gather(Variable, Value)
    
fh_long

ggplot(fh_long, aes(x = Value)) +
    geom_histogram() +
    facet_grid(~ Variable, scales = "free")

```

***

```yaml
type: NormalExercise
key: 101226608c
xp: 50
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}
fh_long <- framingham %>% 
    filter(time == 0) %>% 
    select(cvd, totchol, bmi, age) %>% 
    gather(Variable, Value)
    
fh_long

ggplot(fh_long, aes(x = Value)) +
    geom_histogram() +
    facet_grid(~ Variable, scales = "free")

```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: 16fbde9ec8
xp: 50
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}
fh_long <- framingham %>% 
    filter(time == 0) %>% 
    select(cvd, totchol, bmi, age) %>% 
    gather(Variable, Value)
    
fh_long

ggplot(fh_long, aes(x = Value)) +
    geom_histogram() +
    facet_grid(~ Variable, scales = "free")


```

`@sct`
```{r}

```

---

## Tidy cohort data and wrangling into analyzable form.

```yaml
type: VideoExercise
key: 3d338af036
xp: 50
```

`@projector_key`
4e1f8ff56b37d8caee655cf2b0b4639d

---

## Make discrete variables human-readable

```yaml
type: NormalExercise
key: d905b3eee0
xp: 100
```

{{Convert to tab exercise}}

`@instructions`


`@hint`


`@pre_exercise_code`
```{r}
library(dplyr)
library(forcats)
```

`@sample_code`
```{r}

```

`@solution`
```{r}
framingham %>% 
    mutate(
        sex = case_when(
            sex == 1 ~ "Male",
            sex == 2 ~ "Female",
            TRUE ~ NA_character_
        ), 
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            )
        )
```

`@sct`
```{r}

```

---

## Insert exercise title here

```yaml
type: TabExercise
key: d9c9ebd5d7
xp: 100
```



`@pre_exercise_code`
```{r}

```

***

```yaml
type: NormalExercise
key: d76bbc4aa0
xp: 25
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: d2b17a1c8d
xp: 25
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: b6027a2fe7
xp: 25
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

***

```yaml
type: MultipleChoiceExercise
key: 5ce3ed1c0d
xp: 25
```

`@question`


`@possible_answers`


`@hint`


`@sct`
```{r}

```

---

## Transforming and modifying variables

```yaml
type: VideoExercise
key: bfcfbe9aa2
xp: 50
```

`@projector_key`
5d026dadac109f3540f3c1f59a6f96ea

---

## Reduce number of categories in these datasets

```yaml
type: NormalExercise
key: a721377679
xp: 100
```

{{Convert to tab exercise}}

Sometimes, categorical (i.e. factor or character) variables have many levels,
but only a few observations in one or more levels. For many analyses, this is
not ideal as small sample sizes in some groups make it difficult to ...
{{complete this}}. So, it can be useful to reduce the number of categories by
merging levels together. This can be especially useful if we only want to
interpret one level compared to the other levels.

But first, let's make the values of education understandable, rather than just
numbers.

Reduce the levels of education by using the `fct_recode` function from the
`forcats` package.

`@instructions`


`@hint`


`@pre_exercise_code`
```{r}
library(forcats)
```

`@sample_code`
```{r}

```

`@solution`
```{r}
# Count levels of education
count(framingham, education)

# Merge levels together
fh_educ <- framingham %>% 
    mutate(education_combined = fct_recode(
        education, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational",
        ...
        ))

# Check levels of new variable
count(framingham, education_combined)
# or this? fct_count(framingham$education)
```

`@sct`
```{r}

```

---

## Comparison between different transformations

```yaml
type: TabExercise
key: ca708dca27
xp: 100
```

There are many different types of transformations to use. Which to choose is
dependent on the specific research question, how the data looks, and how you
want your results to be interpreted. Let's see how each transformation changes the data.

`@pre_exercise_code`
```{r}
library(dplyr)
```

`@sample_code`
```{r}
fh_transformed <- framingham %>% 
    mutate(scale_bmi = scale(bmi),
           log_bmi = log(bmi),
           log10_bmi = log10(bmi),
           exp_bmi = bmi^2)
```

***

```yaml
type: NormalExercise
key: 0255ca16ff
xp: 35
```

`@instructions`
-

`@hint`


`@sample_code`
```{r}
fh_transformed <- framingham %>% 
    mutate(scale_bmi = scale(bmi),
           log_bmi = log(bmi),
           log10_bmi = log10(bmi),
           exp_bmi = bmi^2)
```

`@solution`
```{r}
fh_transformed <- framingham %>% 
    mutate(scale_bmi = scale(bmi),
           log_bmi = log(bmi),
           log10_bmi = log10(bmi),
           exp_bmi = bmi^2)
```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: 2422f8318a
xp: 35
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: f4dfabce02
xp: 30
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}
# TODO: show a cohort with continuous outcome, and log that
fh_transformed <- framingham %>% 
    mutate(scale_bmi = as.numeric(scale(bmi)),
           log_bmi = log(bmi),
           log10_bmi = log10(bmi),
           exp_bmi = bmi^2)

fh_transformed %>% 
    select(contains("bmi")) %>% 
    gather(bmi_variable, bmi_value) %>% 
    ggplot(aes(x = bmi_value)) +
    geom_histogram() +
    facet_grid( ~ bmi_variable, scale = "free")

```

`@sct`
```{r}

```

***

```yaml
type: MultipleChoiceExercise
key: 58373c7c64
```

`@question`
Looking at the graph, observe how each transformation influences the distribution of body mass index. Which statement is correct?

`@possible_answers`


`@hint`


`@sct`
```{r}

```
