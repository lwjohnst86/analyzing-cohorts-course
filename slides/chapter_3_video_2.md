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
A difficult part of analysis is identifying and adjusting for potential confounders. Regardless of how you find and adjust for confounders, you need to review other studies and understand the underlying biology.

---
## Classical definition of a confounder

```yaml
type: "FullSlide"
key: "061e68225d"
```

`@part1`
![Confounder](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)

`@script`
The classic definition of a confounder is a variable that can influence both the outcome and the exposure. You'll likely have encountered the concept of confounding in the other epidemiology courses. Understanding confounding is essential to making more accurate inferences about an association. In order to control for confounding, you need to adjust for it in your models.

---
## Creating models: Controlling for confounding

```yaml
type: "FullSlide"
key: "b0f88227c7"
```

`@part1`
- **Very difficult** to completely control confounding
- Danger of not adjusting
    - Lead to actual harm
- Three common approaches:
    - Literature, biological rationale, background knowledge
    - Causal pathways: Directed acyclic graphs (DAG)
    - Model selection: Information criterion methods


`@script`
What does it actually mean to adjust for confounders? In cohorts, confounding gets trickier and more thought must go into what to adjust for. Do the best you can, but be aware you are guaranteed to not include or to not know about all confounders.

Confounding is very important to consider in health research. You should use several approaches to identifying confounders, as they each have strengthes and weaknesses. Using previous knowledge of biology and of the problem and using formal methods such as directed acyclic graphs and information criterion techniques are common approaches.

---
## Confounder identification with DAGs

```yaml
type: "FullSlide"
```

`@part1`

#### Directed Acyclic Graph (DAG)

![DAG](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)

`@script`
One powerful approach to identifying confounding is to draw graphs such as this one, which is called a directed acyclic graph or DAG. Each variable is called a node, and the causal or hypothetical link between variables is called an edge. Creating DAGs helps as it makes hypothetical causal pathways explicit.

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

... Let's make a DAG of this {{3}}


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
You can create DAGs using the dagitty package and dagitty will suggest possible adjustment variables. For example, let's study how height is associated with risk for colon cancer. We know men tend to be taller than women, that men have a higher risk for cancer, that meat intake increases risk for colon cancer, and that men tend to eat more meat. Given this information, what do we adjust for? Let's find out with dagitty! The first argument for the dagitty function takes a character string of a DAG specification. We initialize with the keyword dag, and afterward list each link between variables. In this example, height links with colon cancer, sex links with both height and colon cancer, and so on until all links are drawn. We use the adjustmentSets function on the DAG, set the exposure and the outcome, and then are informed that we should adjust for at least sex. Dagitty especially useful with more complicated pathways.

---
## Visualizing the graph from dagitty

```yaml
type: "TwoColumns"
```

`@part1`

```{r}
plot(graphLayout(possible_confounders))
``` {{1}}

`@part2`

![dagitty graph](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/9b99e7c5a4440bcd2c4a05130bf47c89d3a53dc4/ch3-v2-dagitty.png) {{2}}

`@script`
With this code, you can visualize what the graph looks like. You can see how each variable is linked as we specified. Check this plot to make sure you correctly specified the DAG.

---
## Assessing model fit: Information criterion methods

```yaml
type: "FullSlide"
key: "fdb2dfd109"
```

`@part1`
- Estimates relative model "quality" over others {{1}}
- Trade-off between goodness of fit and number of predictors {{2}}
- Common method: Akaike information criterion (AIC) {{3}}
    - For maximum likelihood models


`@script`
It is best practice to not rely on a single method when deciding what you should adjust for in a DAG. Another method, the information criterion methods, compares several models to find which is better. The method balances model fitness and the number of predictors. Use the Akaike criterion or AIC for models that use maximum likelihood.


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

- *Caution*: Many variables, big dataset, and/or type of model = long computation times {{4}}

`@script`
The MuMIn package implements an easy interface to model selection. First, we need to create a dataframe with only the outcome and predictors of interest, with no missingness. Then we create the model with all variables included by using a dot. We set a binomial family as this is logistic regression. MuMIn requires we set na dot fail. Next we use dredge on the model using AIC. Dredge looks in all combination of models and compares them. In this example, our main exposure is fibre, so we set it with subset.

A short comment on dredge. Since it compares many possible models be careful running it as the computational time may be quite long.

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
## Adhering to the STROBE Statement

```yaml
type: "FullSlide"
key: "a46da48b7d"
```

`@part1`
- **STrengthening the Reporting of OBservational studies in Epidemiology.** (www.strobe-statement.org)

- **Completion of STROBE checklist required for most journals**, such as: {{1}}
    - *"Describe ... methods ... used to control for confounding"* {{2}}
    - *"... which confounders were adjusted for and why ..."* {{2}}
    - *"Give unadjusted estimates and ... confounder-adjusted estimates"* {{2}}


`@script`
While considering confounding is critical to doing rigorous science, another reason is that doing so is required as part of the STROBE checklist. STROBE stands for strengthening the reporting of observational studies in epidemiology and is endorsed internationally by researchers who work with cohort datasets. Use this checklist to focus your analyses and presentation of results and to ensure to adhere to standards of high quality research.

---
## Let's find some confounders!

```yaml
type: "FinalSlide"
key: "56b0010ae1"
```

`@script`
Alright, let's identify confounders!

