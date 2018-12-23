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
In this chapter we'll be covering how and what statistics to apply. But, this gets tricky to teach, which I'll explain shortly. We'll be focusing on general concepts rather than details of a method. We also won't cover interpretation just yet.

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
There are many ways to analyze cohorts and it depends on the data, the research questions, and the study design. Most often, the analysis will be some form of regression modelling. That lets you estimate the magnitude of an association and its uncertainty. So a prospective cohort with multiple measures would often use, for example, mixed effects models, while other designs or with single measures tend to use simpler regression. Cohorts also often study a disease state, which is generally binary, so you'd use a logistic regression form.

From now on we'll use logistic regression in the videos and mixed effects in the exercises. Given there are other more detailed DataCamp courses on these techniques, which we include as prerequisites, we won't cover them in much detail.

---
## Logistic regression

```yaml
type: "FullSlide"
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
Briefly, logistic regression is similar to linear regression, but with a binary outcome. Usually use use this if your, for example, predictor variables are only measured at one time point. The syntax uses glm, with the formula interface of the outcome on the left side and the predictors on the right side, separated by plus signs. You need to set the family to binomial.

Mixed effects models contain a fixed term and a random term. You use this method when data has been collected on, for example, each person many times. You need to use the lme4 package, which contains the glmer function. This function is very similar to glm, except you add a random term by using brackets and a bar. Here, the one indicates that each random unit should have its own intercept. This makes sense as each person will start at their own level in a study. The random id here is the random unit to use, for instance subject id.

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
Some things to keep in mind when thinking of research questions. Cohorts are observational studies, so questions on causes are nearly impossible to answer. Cohorts are about people with common characteristics, so you can't answer questions outside this group. For instance, and something very common, in cohorts with mostly people of European ancestry, you can't get answers about non-European ancestries. 

For prospective cohorts, there is a defined study timeframe, so we can't answer questions outside this time. Finally, if the measurement for an exposure is unreliable or full of error, you can't trust any answer you get. Or if participants come to the data collection visit inconsistently or not at all, your answers will be biased. Keep these in mind when thinking of what to ask.


---
## Let's practice with mixed effects models!

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`
Ok, let's get to practicing now!

