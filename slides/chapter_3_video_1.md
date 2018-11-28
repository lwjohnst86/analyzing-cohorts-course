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

In this chapter we will be covering how and what statistical techniques to apply. But, this is a very tricky thing to teach, for reasons that we will cover in this lesson. So, this chapter will focus on more general concepts that can be used regardless of the statistical method you use. We also won't cover interpretation too much in this chapter, we'll do that more in chapter 4. 

---
## Many data, many questions, many analyses

```yaml
type: "FullSlide"
```

`@part1`

- Analysis depends on the:
    - Data
    - Research question
    - Study design

- Each also depends on the other: {{1}}
    - Some questions restricted by data and design
    - Data restricted by design

`@script`

There are dozens of ways to analyze cohort datasets. How you analyze the data depends on what data you have available, what research questions you want to ask, and what the study design is. And each of these also depends on the others, so you can only ask certain questions based on the data and study design. Likewise, the type of data is restricted by the study design. This is the main reason why this course is designed to cover more general concepts, as only you can come up with questions to research that then dictates your analysis plan.

---
## Common analyses for cohorts

```yaml
type: "FullSlide"
```

`@part1`

- For prospective with multiple measures:
    - *Mixed effects modeling*
    - Generalized estimating equations

- For other study types/single measure:
    - Cox proportional hazard models
    - Linear regression
    - *Logistic regression*
    - Poisson regression

`@script`

So, even though there are many possible analyses you could do, most often the statistical technique is some form of regression modelling. That way, you can estimate the magnitude of an association and its uncertainty. So a prospective cohort with multiple measures often would use, for example, mixed effects models, while other studies designs or with single measures tend to use linear or logistic regression. Cohorts also often study a disease state, which is likely a binary variable, so a simple or mixed effects logistic regression would be used.

For this chapter, we will mainly use logistic regression in the video exercises and mixed effect models in the exercises, so none of the other techniques will be discussed further. Also, this course is not meant to teach these techniques in much detail. We assume you will have taken the other courses that cover those topics in more depth.

---
## Logistic regression and mixed effects models

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

- **Mixed effects**: Has "fixed" and "random" terms, used with multiple measures on same "unit" (e.g. one person over time) {{2}}

```{r}
# Example syntax:
library(lme4)
glmer(outcome ~ predictor1 + predictor2 + 
          (1 | random_id), # e.g. subject_id
      data = dataset, family = binomial)
```{{3}}


`@script`

The two techniques we will briefly describe here. Logistic regression is similar to linear regression, except you have a binary outcome. Usually used when your, for example, predictor variables are only measured at one time point. The syntax uses glm, with the formula interface of the outcome on the left side and the predictors on the right side, separated by plus signs. For logistic regression, you need to set the family to binomial.

Mixed effects models, which have many other names, contain multiple levels, a fixed term and a random term. You use this method when data has been collected on, for example, each person many times. To use mixed effects models, you need to use the lme4 package, which contains the glmer function. This function is very similar to the glm function, except you add a random term by using brackets and a bar. Here, the one indicates that each random unit have its own intercept, which makes sense since each person will start at their own level in a study. The random id here is the random unit to use, for instance subject id.

Like many regression models, the specific values of the predictors can influence whether the model runs or not. In this case, you will likely need to make some transformations to the predictors before a model runs without problems. One function, called I for inhibit, lets you make changes within the formula, which you will try in the exercises.

---
## Keep in mind: Question affected by design and data

```yaml
type: "FullSlide"
```

`@part1`

**Cohorts in general**

- Are observational, can't answer "causes" {{1}}
- Shared characteristics, can't answer outside this {{1}}

**Prospective cohorts** {{2}}

- Risk over a defined time, can't answer outside it {{2}}

**Data in general** {{3}}

- If exposure is unreliably measured, can't trust answers {{3}}
- If variable is inconsistently measured, can't trust answers {{3}}

`@script`

Some things to keep in mind when thinking of questions to research. Cohorts are observational studies, so questions on causes are difficult, or impossible, to answer. Since cohorts are about people with a common characteristics, you can't answer questions outside this group. For instance, and very common, cohorts with mostly persons of European ancestry can't provide answers about non-European ancestries. 

For prospective cohorts, because there is a defined timeframe of the study, we can't answer questions outside this time. Finally, for data in general, if the measurement for an exposure is unreliable or full of error, any answer you do obtain you can't trust. Or if many participants come to the data collection visit inconsistently or not at all, your answers will likely be biased. These are all things to keep in mind when deciding what to ask and how to get at the answer.

---
## Let's practice with mixed effects models!

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`

Ok, let's get to practicing now!
