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
In this chapter, we'll be covering statistical analyses. We'll be focusing on general concepts rather than details of a specific method and won't cover interpretation.


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
    - Logistic regression
    - Poisson regression


`@script`
There are many ways to analyze cohorts, depending on the data, the research questions, and the study design. Most often the analysis will be some form of regression modeling, which provides an estimate of the magnitude of an association and its uncertainty. A prospective cohort with multiple measures over time would often use mixed effects models, while other designs or those with single measures such as at only one time point tend to use simpler regression techniques. Cohorts also often study a disease state, which is generally binary, so you'd likely use a logistic regression model.

For the rest of the chapter, we'll focus on mixed effects modeling.


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
          (1 | random_term), # e.g. subject_id
      data = dataset, family = binomial)
```
{{1}}

`@script`
Mixed effects models are powerful methods that contain a fixed term and a random term. For example, you use this method when data has been collected on each person multiple times, which is common in prospective cohort studies. You'll need to use the lme4 package, which contains the glmer function. If you are familiar with glm, they are very similar except that you add a random term. Let's look into the model formula a bit more.

---
## Formula meaning in mixed models

```yaml
type: "FullSlide"
```

`@part1`

```{r}
# Formula
outcome ~ predictor + (1 | random_term)
```

- `outcome`: $y$ variable. In cohorts, usually disease. {{1}}
- `predictor`: One or more $x$ variable. Variables thought to influence outcome. {{2}}
    - Using more variables: `predictor1 + predictor2 + ...`
- `(1 | random_term)`: Random effects variable. {{3}}
    - Random = dependency between observations (e.g. siblings in family, person over time)
    - Takes form `(left | right)`: left = individual slopes, right = individual intercepts. {{4}}
    - `1` = same slope for all {{5}}
    - `random_term` = each person has own intercept {{5}}

`@script`

There are three parts to a mixed model formula. There's the outcome or y, the predictors or x, and the random term. The outcome is in cohorts usually the disease variable. The predictor part can be one or more predictor variables. Adding more predictors is done by separating them by a plus sign. The predictor variables are the one thought to have some role in the risk for the disease. Lastly, there is variable to use for the random term indicating the random effects. 

The name random indicates a dependency between observations, such as with siblings in a family or a person measured over time. The form has two parts, a left side and right side. The left side is to calculate slopes for each random unit while the right side is to calculate intercepts for each unit. The one here says have the same slopes and the random term on the right says to have different intercepts for each term. For example, in a prospective cohort, individuals measured over time will generally start at their own level at the start, which makes sense, since not every person starts at the same, for example, weight.

---
## Recall transforming variables for modelling

```yaml
type: "FullSlide"
key: "d4dd5e98fc"
```

`@part1`

```{r}
# Example transforming: Center, division, log
changed_dataset <- dataset %>% 
    mutate(center_predictor = scale(predictor1, scale = FALSE),
           predictor_divided_num = predictor2 / num,
           log_predictor = log(predictor))
``` 
{{1}}

- For mixed models, large differences in variances between variables is common issue {{2}}
    - E.g. Weight of mother in kg and weight of newborn in grams
- Often involves trial and error for transformations {{3}}

`@script`

In chapter 2 we covered transforming variables. Here we can put that knowledge to use. Some modelling techniques are fussy when it comes to what data you give it. Usually the code runs checks and informs you of any issue. For instance, with mixed effects models, large differences in the variances of variables included in the formula can cause warnings and errors when running glmer. So you'll often have to do some trial and error of scaling, logging, or any other mathematically transformations of predictors before the model computes a more correct output.

---
## Running mixed effects models using glmer

```yaml
type: "FullSlide"
key: "d4dd5e98fc"
```

`@part1`

```{r}
library(lme4)
glmer(outcome ~ center_predictor + predictor_divided_100 + 
          log_predictor + (1 | random_id), # e.g. subject_id
      data = changed_dataset, family = binomial)
``` 
{{1}}


`@script`

We've covered what to include in the formula and transforming some variables. Now it's time to put it all together in the glmer function. The function takes several arguments, but the three most important ones are the formula, the data, and the family function. The family function is used to indicate how to handle the outcome variable. In this case, the outcome is binary: You have the disease or not. So, you need to use the binomial distribution family to obtain the correct results.

TODO: Include interpretation here?


---
## Let's practice with mixed effects models!

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`
Let's do some practice!

