---
title: 'Exploring, wrangling, and transforming cohort data'
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
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/78dd9ad366a4497984a94aa0558ffb8c1d1a044c/framingham_tidier.rda"))
library(forcats)
library(dplyr)
library(tidyr)
library(ggplot2)
```

`@sample_code`
```{r}

```

`@solution`
```{r}
tidier_framingham %>% 
    select(followup_visit_number, got_cvd, total_cholesterol, participant_age, body_mass_index,
           currently_smokes) %>% 
    mutate(got_cvd = forcats::as_factor(as.character(got_cvd))) %>% 
    gather(Variable, Value, -followup_visit_number, -got_cvd) %>% 
    ggplot(aes(x = Value, group = got_cvd, fill = got_cvd)) +
    geom_density(alpha = 0.6) +
    facet_grid(followup_visit_number ~ Variable, scales = "free")
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
```

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

## Tidy, then merge categories of discrete variables

```yaml
type: TabExercise
key: d9c9ebd5d7
xp: 100
```

Sometimes, categorical (i.e. factor or character) variables have many levels, but only a few observations in one or more levels. For some analyses or for particular questions, it might make sense to combine categories together. This is especially useful if we only want to interpret one level compared to the other levels.

Before we group together categories of a factor, we need to tidy it up. Often you will encounter discrete data as integers rather than human understandable strings. Let's fix up education, so it is understandable. Then merge some of the categories together.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/78dd9ad366a4497984a94aa0558ffb8c1d1a044c/framingham_tidier.rda"))
library(forcats)
library(dplyr)
```

***

```yaml
type: NormalExercise
key: d76bbc4aa0
xp: 25
```

`@instructions`

- Check the original levels of education.
- Convert the education values to human readable format using `case_when` inside of `mutate`.
- The original education numbers should correspond to the following:
    - 1: "0-11 years"
    - 2: "High School"
    - 3: "Vocational"
    - 4: "College"
- Confirm they were appropriately changed.

`@hint`


`@sample_code`
```{r}
# Count levels of original education
___(tidier_framingham, ___)

# Convert education to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = ___(
            # Use the format: variable == number ~ "string"
            ___ == ___ ~ ___,
            ___ == ___ ~ ___,
            ___ == ___ ~ ___,
            ___ == ___ ~ ___,
            # Need this as last value
            TRUE ~ NA_character_
            )
        )

# Confirm changes to revised education
___(tidier2_framingham, ___)
```

`@solution`
```{r}
# Check levels of original education
count(tidier_framingham, education)

# Convert education to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            # Need this as last value
            TRUE ~ NA_character_
            )
        )

# Confirm changes to revised education
count(tidier2_framingham, education)
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
# Check levels of original education
count(tidier_framingham, education)

# Convert education to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            )
        )

# Confirm changes to revised education
count(tidier2_framingham, education)

# Merge college and vocational levels together
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = fct_recode(
        education, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))

# Check changes to reduced education
count(tidier2_framingham, education_combined)

```

`@solution`
```{r}
# Check levels of original education
count(tidier_framingham, education)

# Convert education to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            )
        )

# Confirm changes to revised education
count(tidier2_framingham, education)

# Merge college and vocational levels together
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = fct_recode(
        education, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))

# Check changes to reduced education
count(tidier2_framingham, education_combined)

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

- Reduce the levels of education by using the `fct_recode` function from the
`forcats` package.

`@hint`


`@sample_code`
```{r}
# Check levels of original education
count(tidier_framingham, education)

# Convert education to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            )
        )

# Confirm changes to revised education
count(tidier2_framingham, education)

# Merge college and vocational levels together
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = fct_recode(
        education, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))

# Check changes to reduced education
count(tidier2_framingham, education_combined)

```

`@solution`
```{r}
# Check levels of original education
count(tidier_framingham, education)

# Convert education to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            )
        )

# Confirm changes to revised education
count(tidier2_framingham, education)

# Merge college and vocational levels together
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = fct_recode(
        education, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))

# Check changes to reduced education
count(tidier2_framingham, education_combined)
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

Why is it ok to convert 

`@possible_answers`


`@hint`


`@sct`
```{r}

```


---

## Compare different types of transformations

```yaml
type: TabExercise
key: ca708dca27
xp: 100
```

There are several types of transformations you can choose from. Which one you choose depends on the question, the data values, the statistical method you use, and how you want your results to be interpreted. In later chapters we will cover how each transformation changes how you interpret the results of your analyses. 

Use several transformations on body mass index {{other one?}} and visually compare each one to the original values.

`@pre_exercise_code`
```{r}
library(dplyr)
library(tidyr)
library(ggplot2)
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/78dd9ad366a4497984a94aa0558ffb8c1d1a044c/framingham_tidier.rda"))
```

`@sample_code`
```{r}
# Use four transformations on body mass index
transformed_framingham <- tidier_framingham %>% 
    mutate(scale_body_mass_index = ___(___),
           log_body_mass_index = ___(___),
           log10_body_mass_index = ___(___),
           sqrt_body_mass_index = ___(___))

# Confirm variables have been created
transformed_framingham
```

***

```yaml
type: NormalExercise
key: 0255ca16ff
xp: 35
```

`@instructions`

`@hint`


`@sample_code`
```{r}
# Use four transformations on body mass index
transformed_framingham <- tidier_framingham %>% 
    mutate(scale_body_mass_index = ___(body_mass_index),
           log_body_mass_index = ___(body_mass_index),
           log10_body_mass_index = ___(body_mass_index),
           sqrt_body_mass_index = ___(body_mass_index))

# Confirm variables have been created
transformed_framingham
```

`@solution`
```{r}
# Use four transformations on body mass index
transformed_framingham <- tidier_framingham %>% 
    mutate(scale_body_mass_index = scale(body_mass_index),
           log_body_mass_index = log(body_mass_index),
           log10_body_mass_index = log10(body_mass_index),
           sqrt_body_mass_index = sqrt(body_mass_index))

# Confirm variables have been created
transformed_framingham
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
# Use four transformations on body mass index
transformed_framingham <- tidier_framingham %>% 
    mutate(scale_body_mass_index = scale(body_mass_index),
           log_body_mass_index = log(body_mass_index),
           log10_body_mass_index = log10(body_mass_index),
           sqrt_body_mass_index = sqrt(body_mass_index))

# Gather the body mass index variables into long form
transformed_framingham %>% 
    gather(bmi_variable, bmi_value, contains("body_mass_index")) 
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
# Use four transformations on body mass index
transformed_framingham <- tidier_framingham %>% 
    mutate(scale_body_mass_index = scale(body_mass_index),
           log_body_mass_index = log(body_mass_index),
           log10_body_mass_index = log10(body_mass_index),
           sqrt_body_mass_index = sqrt(body_mass_index))

# Visually inspect the transformations
transformed_framingham %>% 
    gather(bmi_variable, bmi_value, contains("body_mass_index")) %>% 
    ggplot(aes(x = bmi_value)) +
    geom_histogram() +
    facet_wrap( ~ bmi_variable, scale = "free")

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
