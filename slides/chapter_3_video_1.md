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
There are many ways to analyze cohorts, depending on the data, the research questions, and the study design. For prospective cohorts with multiple measures over time, you would generally use mixed effects or generalized estimated equations, while other study designs tend to use simpler techniques such as linear or logistic regression or cox models. Cohorts usually study a disease, which is generally binary like has or doesn't have, and requires techniques that use a binomial distribution.

For the rest of the chapter, we'll focus on mixed effects modeling.


---
## Mixed effects models

```yaml
type: "FullSlide"
key: "029e25b56b"
```

`@part1`
- **Mixed effects**: 
    - Has "fixed" (population-level) and "random" (individual-level) terms
    - Used with multiple measures on same "statistical unit" (e.g. person over time)

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
Mixed effects models are powerful methods that contain a fixed term that indicates the overall effect and a random term that indicates the individual effect. You would use this method when data has been collected on each participant multiple times, as is common in prospective cohorts. 

We'll use the glmer function from lme4. If you are familiar with the glm function, or with generalized linear models, glmer is very similar except that you add a random term.


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

- `outcome`: $y$ variable. In cohorts, usually disease {{1}}
- `predictor`: One or more $x$ variable {{2}}
    - Fixed terms
    - Variables thought to influence outcome
    - Using more variables: `predictor1 + predictor2 + ...`


`@script`
There are three parts to a mixed model formula: the outcome or y, the predictors or x, and the random term. 

The outcome in cohorts is usually the disease. 

The predictor is the fixed term and can be one or more predictor variables, separated by a plus sign. The main predictor of interest, called the exposure, is the one we hypothesize has a role in the the disease. Other predictors include potential confounders, which we will cover later.


---
## Formula meaning in mixed models

```yaml
type: "FullSlide"
key: "6258135d76"
disable_transition: true
```

`@part1`
```{r}
# Formula
outcome ~ predictor + (1 | random_term)
```

- `(1 | random_term)`: Random effects variable
    - Random = dependency between observations (e.g. siblings in family, person over time) {{1}}
    - Takes form `(left | right)`: left = individual slopes, right = individual intercepts {{2}}
    - `1` = same slope for all {{3}}
    - `random_term` = each person has own intercept {{4}}


`@script`
Lastly, there is the random effects variable. The name random means there is a dependency between observations, such as with siblings in a family or a person measured over time. 

The form has two parts, a left and right side. The left side calculates slopes for each random unit while the right side calculates intercepts for each unit. The one here says to have the same slopes and that each random unit on the right will have a different intercept. For example, in a prospective cohort, individuals measured over time will all start at their own weight at the start and change over time.


---
## Recall transforming variables for modeling

```yaml
type: "FullSlide"
key: "a652496216"
```

`@part1`
```{r}
# Example code for transforming: Center, division, log
changed_dataset <- dataset %>% 
    mutate(predictor_center = scale(predictor, scale = FALSE),
           predictor_divided_num = predictor / num,
           predictor_log = log(predictor))
``` 
{{1}}

- For mixed models, large differences in variable variances is common issue {{2}}
    - E.g. Weight of mother in kg and weight of newborn in grams
- Often involves trial and error for transformations {{3}}


`@script`
In chapter 2 we covered transforming variables. Here we will put that knowledge to use. Some modeling techniques are fussy with the data you give it. Usually the model function informs you of any issue. 

For instance, with mixed effects models, large differences in the variances of variables in the formula can cause computational problems. A good example would be the weight differences between a mother in kg and a newborn in grams.

You'll often have to do some trial and error of scaling, logging, or other transformations  before the model computes a correct error-free output.


---
## Running mixed effects models using glmer

```yaml
type: "FullSlide"
key: "d2067f83af"
```

`@part1`
```{r}
# Example code usage:
library(lme4)
glmer(outcome ~ center_predictor + predictor_divided_100 + 
          log_predictor + (1 | random_id), # e.g. subject_id
      data = changed_dataset, family = binomial)
``` 
{{1}}


`@script`
We've covered what to include in the formula and how to transform some variables. Now for how we put it together in the glmer function. glmer takes several arguments, but the three most important ones are the formula, the data, and the family function. The family argument is used to indicate how to handle the outcome variable. Since the outcome is binary, you either have the disease or don't, we need to use the binomial distribution family to obtain the correct results.


---
## Lesson summary

```yaml
type: "FullSlide"
key: "5a9db8b0fa"
```

`@part1`
- Mixed effects models commonly used
- Fixed for population, random for individual
- `glmer()` takes three arguments: formula, data, family
- Formula: `y ~ x + (1 | random)`
    - Any variable, including transformed can be added


`@script`
To summarize, mixed effects models are common, allow you to consider individual's differences with the random term, that the glmer takes three arguments, and that the formula can include any variable in the dataset.


---
## Let's practice with mixed effects models!

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`
Let's do some practice!

