---
title: Adjustment, confounding, and model building
key: 911feb6e308d8e7e180f7f33f32a51ed

---
## Adjustment, confounding, and model building

```yaml
type: "TitleSlide"
key: "9f03a6de45"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
One of the trickier parts of the analysis is identifying and adjusting for potential confounders. There are many ways of finding and adjusting for confounders. Regardless of what you use, you need to at least review what other studies have done and what the underlying biology is. This requires domain specific knowledge, so collaborate with people who have that knowledge.


---
## Adhering to guidelines: STROBE Statement

```yaml
type: "FullSlide"
key: "a46da48b7d"
```

`@part1`
- **STrengthening the Reporting of OBservational studies in Epidemiology.** (www.strobe-statement.org)

- **Most journals require completion of STROBE checklist**, including to: {{1}}
    - *"Describe ... methods ... used to control for confounding"* {{2}}
    - *"Make clear which confounders were adjusted for and why they were included"* {{2}}
    - *"Give unadjusted estimates and ... confounder-adjusted estimates"* {{2}}


`@script`
Before going further, let's talk about the key guideline for cohort analyses, which is STROBE, or strengthening the reporting of observational studies in epidemiology. Use this checklist to guide your analyses and final presentation of results. This checklist forces you to think about at least the minimum thing to do. For instance, why and how confounders were chosen and included. We'll be returning to STROBE many times.


---
## Creating models: Controlling for confounding

```yaml
type: "FullSlide"
key: "b0f88227c7"
```

`@part1`
- **Very difficult** to completely control for confounding
- Danger of not adjusting
    - Could lead to actual harm
- Three common empirical and systematic approaches to identifying confounders:
    - Literature, biological rationale, background knowledge
    - Causal pathways: Directed acyclic graphs (DAG)
    - Model selection: Information criterion methods


`@script`
What does it mean to adjust for confounders? What is a confounder? You'll likely encounter confounding in other epidemiology courses, so I won't cover it much here. For cross-sectional analyses, adjusting for confounding is fairly easy, since there is no time-component. But in cohorts, confounding gets trickier and more thought must go into what to adjust for. Do the best you can, but be aware you are guaranteed to not include or to not know about all confounders.

Confounding is very very important to consider in health research. There are several ways to identify confounders. Using previous knowledge of biology and of the problem and using formal methods such as directed acyclic graphs and information criterion techniques are common approaches.


---
## Classical definition of a confounder

```yaml
type: "FullSlide"
key: "061e68225d"
```

`@part1`
![DAG](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)

- This graphic is called a *directed acyclic graph*


`@script`
The classic definition of a confounder is a variable that can influence both the outcome and the exposure. Understanding confounding is essential to making more accurate inferences about an association. This graph is called a directed acyclic graph or DAG. Creating DAGs is a powerful and insightful approach to finding confounders because they make explicit hypothetical causal pathways.


---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
key: "22d8c21829"
```

`@part1`
An example: Height with colon cancer. But... {{1}}

- Men are taller {{2}}
- Men more likely to get cancer {{2}}
- More meat, more likely to get colon cancer {{2}}
- Men tend to eat more meat {{2}}

... Let's make a DAG of this. {{3}}


`@part2`
&nbsp;

```{r}
possible_confounders <- dagitty(
"dag {
  Height -> ColonCancer
  Sex -> {Height ColonCancer}
  Sex -> MeatIntake -> ColonCancer
}") 
``` {{3}}

```{r}
adjustmentSets(
    possible_confounders,
    exposure = "Height",
    outcome = "ColonCancer") 
#>  { Sex }
``` {{4}}


`@script`
You can create DAGs using the dagitty package and dagitty will suggest possible adjustment variables. Here's an example. We will study how height associates with risk for colon cancer. But, we know that men tend to be taller than women, that men tend to have a higher risk for cancer, that meat intake increases risk for colon cancer, and that men tend to eat more meat. Given this information, what do we adjust for? Let's find out with dagitty! The first argument for the dagitty function takes a character string of a DAG specification. We initialise with the keyword dag, and afterward list each link between variables. Height links with colon cancer, sex links with both height and colon cancer, and so on until all links are drawn. We use the adjustmentsets function on the DAG, set the exposure and the outcome, and then are informed that we should adjust for at least sex. Dagitty is very useful especially with more complicated pathways.


---
## Assessing model fit: Information criterion methods

```yaml
type: "FullSlide"
key: "fdb2dfd109"
```

`@part1`
- Estimates relative model "quality" over other models. {{1}}
- Trade-off between the goodness of fit and simplicity (number of predictors). {{2}}
- Common method: Akaike information criterion (AIC). {{3}}
    - For models that use maximum likelihood (most regression-based methods).


`@script`
You should never rely on only one method for deciding what to adjust for. So useful technique is the information criterion methods, which compare several models to find which is better. The method balances model fitness and the number of predictors. Use the Akaike criterion or AIC for models that use maximum likelihood.


---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "51eddc42eb"
```

`@part1`
```{r}
# Keep only interested predictors and no missing
cleaned_diet <- diet %>%
    mutate(bmi = weight / (height / 100)^2) %>%
    select(energy, bmi, fat, fibre, chd) %>%
    na.omit() 
``` {{1}}

```{r}
# Logistic regression, all predictors
full_model <- glm(chd ~ ., data = cleaned_diet,
                  family = binomial, na.action = "na.fail") 
``` {{2}}

```{r}
# Models with every combination of predictor
model_comparison <- dredge(full_model, rank = "AIC", subset = "fibre")
``` {{3}}

- *Caution*: Too many variables, a big dataset, and/or type of model will lead to long computation times {{4}}
- **Don't** rely on *only* this method for model building {{5}}


`@script`
The MuMIn package implements an easy interface to model selection. But first, we need to create a dataframe with only the outcome and predictors of interest, with no missingness. Then we create the model with all variables included by using a dot. We set a binomial family as this is logistic regression. MuMIn requires we set na dot fail. Next we use dredge on the model using AIC. In this example, our main exposure is fibre, so we set it in subset.

A comment about dredge. It compares models with every possible combination of variables... so be careful as R may run for a long time. Also, as I said, use different methods to decide on what to adjust for.


---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "276321afb5"
```

`@part1`
```{r}
head(model_selection, 4)
``` {{1}}

```
#> Global model call: glm(formula = chd ~ ., family = binomial, data = cleaned_diet, 
#>     na.action = "na.fail")
#> ---
#> Model selection table 
#>    (Intrc)     bmi     enrgy     fat   fibre df   logLik   AIC delta weight
#> 14 -0.4290 0.09605           -0.1752 -0.9882  4 -120.996 250.0  0.00  0.435
#> 13  1.3510                   -0.1579 -0.7839  3 -122.598 251.2  1.20  0.238
#> 12 -0.4436 0.08922 -0.074450         -0.9432  4 -121.964 251.9  1.94  0.165
#> 16 -0.4920 0.09616  0.008187 -0.1861 -1.0070  5 -120.990 252.0  1.99  0.161
#> Models ranked by AIC(x) 
``` {{2}}


`@script`
Use head to see the top four models. The AIC column shows the models are all very similar. This tell us a few things, such as these variables may not contribute substantially to model fit. We could be fairly safe with using any of these models.


---
## Let's find some confounders!

```yaml
type: "FinalSlide"
key: "56b0010ae1"
```

`@script`
Alright, let's identify confounders!

