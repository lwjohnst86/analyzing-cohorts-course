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
In this chapter, we'll be covering statistical analyses. We'll be focusing on general concepts rather than details of a method and won't cover interpretation just yet.


---
## Many data, many questions, many analyses

```yaml
type: "FullSlide"
key: "44ebb0b342"
```

`@part1`
- Analysis depends on:
    - Data
    - Research question
    - Study design

- Each depends on others: {{1}}
    - Some questions restricted by data and design
    - Data restricted by design


`@script`
There are many ways to analyze cohorts. What and how you analyze depends on the data you have, what questions you ask, and what the study design is. They also depend on each other, for instance, what your questions are will be based on the data and study design. Likewise, the study design will restrict the data. This is the reason why we'll cover general concepts, your research questions will vary as you study different datasets, which then dictates your analysis.


---
## Common analyses for cohorts

```yaml
type: "FullSlide"
key: "d7c7602043"
```

`@part1`
- For prospective with multiple measures:
    - **Mixed effects modeling**
    - Generalized estimating equations

- For other study types/single measure:
    - Cox proportional hazard models
    - Linear regression
    - **Logistic regression**
    - Poisson regression


`@script`
While there are many possible analyses, most often will be some form of regression modeling, which provides an estimate of the magnitude of an association and its uncertainty. A prospective cohort with multiple measures would often use mixed effects models, while other designs or with single measures tend to use simpler regression. Cohorts also often study a disease state, which is generally binary, so you'd use a logistic regression form.

From now on we'll use logistic regression in the videos and mixed effects in the exercises.


---
## Logistic regression and mixed effects models

```yaml
type: "FullSlide"
key: "f17e57faa8"
```

`@part1`
- **Logistic regression**: Similar to linear regression, used when only one timepoint

```{r}
# Example syntax:
glm(outcome ~ predictor1 + predictor2, 
    data = dataset, family = binomial)
```{{1}}

- **Mixed effects**: Has "fixed" and "random" terms, used with multiple measures on same "unit" {{2}}

```{r}
# Example syntax:
library(lme4)
glmer(outcome ~ predictor1 + predictor2 + 
          (1 | random_id), # e.g. subject_id
      data = dataset, family = binomial)
```{{3}}


`@script`
Briefly, logistic regression is similar to linear regression, but with a binary outcome. Usually, you use this when your predictor variables are only measured at a single time point. The syntax uses glm with the formula interface of the outcome on the left side and the predictors on the right side, separated by plus signs. You need to set the family to binomial.

Mixed effects models contain a fixed term and a random term. For example, you use this method when data has been collected on each person many times. You need to use the lme4 package, which contains the glmer function. This function is very similar to glm, except you add a random term by using brackets and a bar. Here, the one indicates that each random unit should have its own intercept. This makes sense as each person will start at their own level in a study. The random id here is the random unit to use, for instance, subject id.

Like many regression models, the specific numerical values of the predictors can influence whether the model runs or not. In this case, you will likely need to transform the predictors so the model runs without problems. One function, called I for inhibit, lets you make changes to the predictor within the formula. You'll use it in the exercises.


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
Remember, research questions are restricted by both study design and the data collected. Cohorts are observational studies, so questions on causes are nearly impossible to answer. Cohorts are about people with common characteristics, so you can't answer questions outside the group that is studied. 

For prospective cohorts, there is a defined study timeframe, so we can't answer questions outside this time. Finally, exposure measurements may be unreliable, or participant data may not be consistently collected, which will make your answer biased.


---
## Let's practice with mixed effects models!

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`
Let's practice!

