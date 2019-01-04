---
title: Statistical analyses for cohort studies
key: 5ab6b9af44fc27034571fab5f10ca3ef

---
## Statistical analyses for cohort studies

```yaml
type: "TitleSlide"
key: "0d2a8f7826"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
In this chapter, we'll be covering statistical analyses. We'll be focusing on general concepts rather than details of an specific method and won't cover interpretation just yet.


---
## Common analyses for cohorts

```yaml
type: "FullSlide"
key: "d7c7602043"
```

`@part1`
- For prospective with multiple measures: {{1}}
    - **Mixed effects modeling**
    - Generalized estimating equations

- For other study types/single measure: {{2}}
    - Cox proportional hazard models
    - Linear regression
    - **Logistic regression**
    - Poisson regression


`@script`
There are many ways to analyze cohorts, depending on the data, the research questions, and the study design. Most often the analysis will be some form of regression modeling, which provides an estimate of the magnitude of an association and its uncertainty. A prospective cohort with multiple measures over time would often use mixed effects models, while other designs or those with single measures such as at only one time point tend to use simpler regression techniques. Cohorts also often study a disease state, which is generally binary, so you'd likely use a logistic regression model.

For the rest of the chapter we'll use logistic regression in the videos and mixed effects in the exercises.


---
## Logistic regression

```yaml
type: "FullSlide"
key: "3b69b894db"
```

`@part1`
- **Logistic regression**: 
    - Similar to linear regression
    - With binary outcome 
    - Used when only one timepoint

```{r}
# Example syntax:
glm(outcome ~ predictor1 + predictor2, 
    data = dataset, family = binomial)
```{{1}}


`@script`
You'll have encountered logistic regression in the prerequisite course, but in simple terms, it is similar to linear regression, but with a binary outcome and used when your predictor variables are only measured at a single time point. The syntax uses glm with the formula interface of the outcome on the left side and the predictors on the right side, separated by plus signs. You need to set the family to binomial since the outcome is binary.


---
## Mixed effects models

```yaml
type: "FullSlide"
key: "029e25b56b"
```

`@part1`
- **Mixed effects**: 
    - Has "fixed" and "random" terms
    - Used with multiple measures on same "unit" (e.g. over time)

```{r}
# Example syntax:
library(lme4)
glmer(outcome ~ predictor1 + predictor2 + 
          (1 | random_id), # e.g. subject_id
      data = dataset, family = binomial)
```


`@script`
Mixed effects models meanwhile are more powerful and contain a fixed term and a random term. For example, you use this method when data has been collected on each person multiple times. You'll need to use the lme4 package, which contains the glmer function. This function is very similar to glm, except you add a random term by using brackets and a bar. Here, the one in the brackets indicates that each random unit should have its own intercept. This makes sense as each person will start at their own level in a study. The random id here is the random unit to use, such as the subject id.


---
## Transforming variables for modelling

```yaml
type: "FullSlide"
key: "d4dd5e98fc"
```

`@part1`
```{r}
# Example:
library(lme4)
``` {{1}}

```{r}
# Before modelling
changed_dataset <- dataset %>% 
    mutate(center_predictor = scale(predictor1, scale = FALSE),
           predictor_divided_100 = predictor2 / 100)

glmer(outcome ~ center_predictor + predictor_divided_100 + 
          (1 | random_id), # e.g. subject_id
      data = changed_dataset, family = binomial)
``` {{2}}

```{r}
# During modelling
glmer(outcome ~ scale(predictor1, scale = FALSE) + # mean center
        I(predictor2 / 100) + # Divide by 100
        (1 | random_id), # e.g. subject_id
      data = dataset, family = binomial)
``` {{3}}


`@script`
Many regression models can be strongly influenced by large differences in numerical values between predictors. The reasons are due to the underlying mathematics of the model. For our purposes, you only need to know that you may need to change the values, for example by making them smaller by dividing by 100. Usually the model will let you know there is a problem. If changes are needed, you will have to transform the variables, as you learned in chapter 2. You can do this two ways. Here, you can transform the variables beforehand and use the transformed variables in the model. Or, you can directly transform variables in the model formula. For transformation such as addition or division, you need to use the I function wrapped around the transformation.


---
## Keep in mind: Question is restricted by design and data

```yaml
type: "FullSlide"
key: "d4bbe2304d"
```

`@part1`
**Cohorts in general**
- Are observational {{1}}
- Shared characteristics {{1}}

**Prospective cohorts** {{2}}
- Has a defined time {{2}}

**Data in general** {{3}}
- Exposure may be unreliably measured {{3}}
- Variable may be inconsistently measured {{3}}


`@script`
Something to keep in mind. Research questions are limited by both study design and the type of data collected. Cohorts are observational studies, so questions on causes are nearly impossible to answer. Cohorts are about people with common characteristics, so you can't answer questions outside the group that is studied. 

For prospective cohorts, there is a defined study timeframe, so we can't answer questions outside this time. Finally, exposure measurements may be unreliable, or participant data may not be consistently collected, which will make your answer biased.


---
## Let's practice with mixed effects models!

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`
Let's do some practice!

