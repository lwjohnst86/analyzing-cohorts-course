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
title: Diabetes epidemiologist


`@script`
In this chapter, we'll be covering statistical analyses. We'll be focusing mainly on general concepts but with a focus on a common and powerful statistical technique.


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


`@script`
There are many ways to analyze cohorts, depending on the data, the research questions, and the study design. For prospective cohorts with multiple measures over time, you would generally use mixed effects or generalized estimated equations, while other study designs tend to use simpler techniques such as linear or logistic regression or cox models. Cohorts usually study a disease, which is generally binary, so you'd likely use a logistic regression-type methods, including with mixed effects models.

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

&nbsp;

```{r}
# Example syntax:
library(lme4)
glmer(outcome ~ predictor1 + predictor2 + 
          (1 | random_term), # e.g. subject_id
      data = dataset, family = binomial)
```
{{1}}


`@script`
Mixed effects models are powerful methods that contain a fixed term and a random term. For example, you use this method when data has been collected on each person multiple times, commonly done in prospective cohort studies. 

You'll need to use the lme4 package, which contains the glmer function. If you are familiar with the function glm, or generalized linear models, glmer is very similar except that you add a random term. Let's look into the model formula a bit more.


---
## Formula meaning in mixed models

```yaml
type: "FullSlide"
key: "74f16c7a54"
```

`@part1`
```{r}
# Formula
outcome ~ predictor + (1 | random_term)
```

- `outcome`: $y$ variable. In cohorts, usually disease. {{1}}
- `predictor`: One or more $x$ variable. Variables thought to influence outcome. {{2}}
    - Using more variables: `predictor1 + predictor2 + ...`


`@script`
There are three parts to a mixed model formula: the outcome or y, the predictors or x, and the random term. 

The outcome in cohorts is usually the disease variable. 

The predictor part can be one or more predictor variables. You can add more predictors by separating them with a plus sign. The predictor variable of interest, called the exposure, is the one we hypothesize has a role in the the disease. Other predictors included are the confounders, which we will cover later.


---
## Formula meaning in mixed models

```yaml
type: "FullSlide"
key: "6258135d76"
```

`@part1`
```{r}
# Formula
outcome ~ predictor + (1 | random_term)
```

- `(1 | random_term)`: Random effects variable.
    - Random = dependency between observations (e.g. siblings in family, person over time) {{1}}
    - Takes form `(left | right)`: left = individual slopes, right = individual intercepts. {{2}}
    - `1` = same slope for all {{3}}
    - `random_term` = each person has own intercept {{4}}


`@script`
Lastly, there is variable for the random effects. The name random means there is a dependency between observations, such as with siblings in a family or a person measured over time. 

The form has two parts, a left and right side. The left side calculates slopes for each random unit while the right side calculates intercepts for each unit. The one here says to have the same slopes and that each group in the random term on the right has a different intercept. For example, in a prospective cohort, individuals measured over time will generally start at their own level at the start. For example, everyone starts at a their own weight but that it may change over time.


---
## Recall transforming variables for modelling

```yaml
type: "FullSlide"
key: "a652496216"
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
In chapter 2 we covered transforming variables. Here we can put that knowledge to use. Some modeling techniques are fussy with the data you give it. Usually the code checks and informs you of any issue. 

For instance, with mixed effects models, large differences in the variances of variables in the formula can cause computational problems. A good example would be the weight differences between a mother and newborn.

You'll often have to do some trial and error of scaling, logging, or other transformations  before the model computes a correct output.


---
## Running mixed effects models using glmer

```yaml
type: "FullSlide"
key: "d2067f83af"
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
We've covered what to include in the formula and how to transform some variables. Now it's time to put it all together in the glmer function. The function takes several arguments, but the three most important ones are the formula, the data, and the family function. The family argument is used to indicate how to handle the outcome variable. In this case, the outcome is binary: You have the disease or not. So, you need to use the binomial distribution family to obtain the correct result.


---
## Let's practice with mixed effects models!

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`
Let's do some practice!

