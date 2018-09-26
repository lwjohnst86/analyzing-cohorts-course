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

Create a simple visual comparing the outcome with the exposures.

{{convert to tab exercise}}

`@instructions`


`@hint`


`@pre_exercise_code`

```{r setup}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
```


`@sample_code`

```{r}

```


`@solution`

```{r}
framingham %>% 
    select(time, cvd, totchol, age, bmi) %>% 
    gather(Variable, Value, -time, -cvd) %>% 
    mutate(cvd = as.factor(cvd)) %>% 
    ggplot(aes(x = Value, group = cvd, fill = cvd)) +
    geom_density(alpha = 0.6) +
    facet_grid(~ Variable, scales = "free")
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


Sometimes, categorical (factor or character) variables have many levels, but only
a few observations in each level. For analyses, this is less than ideal, so it
is often useful to reduce the total number of categories by merging levels together.
This can be especially useful if interpretation of only one level is desired
compared to other levels.

Reduce the levels of education by using the `fct_recode` function from the 
`forcats` package.

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
library(forcats)
fh_educ <- framingham %>% 
    mutate(educ_reduced = fct_recode(
        educ, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))

# Compare the original education variable with the reduced one
fct_count(fh_educ$educ)
fct_count(fh_educ$educ_reduced)
# TODO: Add another dataset to reduce categories e.g. PROMISE and ethnicity

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

Using different types of transformations is dependent on the specific research
question and how the data looks. It's useful to understand what each types of 
transformations do to the available data.

Explore the transforms visually.


`@pre_exercise_code`

```{r}

```


`@sample_code`

```{r}

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
