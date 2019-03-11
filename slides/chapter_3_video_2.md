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
A difficult part of the analysis is controlling for potential confounders.


---
## Classical definition of a confounder

```yaml
type: "FullSlide"
key: "061e68225d"
```

`@part1`
![Confounder](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)


`@script`
A confounder is a variable that can influence both the outcome and the exposure. You'll likely have encountered the concept of confounding in the other courses. Understanding confounding is essential in making valid inferences. To control for confounding, you need to include it in your models.


---
## Creating models: Controlling for confounding

```yaml
type: "FullSlide"
key: "b0f88227c7"
```

`@part1`
- **Very difficult** to completely control/adjust for confounding
- Three common approaches:
    - Literature, biological rationale, background knowledge
    - Causal pathways: Directed acyclic graphs (DAG)
    - Model selection: Information criterion methods


`@script`
What does it mean to adjust for confounders? Confounding is tricky in cohorts and requires substantial consideration. Do the best you can, but be aware you are guaranteed to not include or to not know about all confounders.

Considering confounding is vital in health research. You should use several approaches when identifying confounders, as they each have strengths and weaknesses. Use previous biological and domain knowledge and formal methods such as directed acyclic graphs, or DAGs, and information criterion techniques.


---
## Identify confounders with Directed Acyclic Graphs (DAG)

```yaml
type: "FullSlide"
key: "669761f7ba"
```

`@part1`

![DAG](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)

- Directed = A link with a direction. A cause and an effect. {{1}}
- Acyclic = Pathways don't loop (cycle) back. {{2}}
- Graph = Any type of representation of links between objects. {{3}}

`@script`

Drawing graphs like this DAG is a powerful approach to finding confounders. Each variable is called a node, and the causal or hypothetical link between variables is called an edge. Creating DAGs makes hypothetical confounding pathways explicit.

Let's breakdown the meaning of DAG. Directed indicates a directionality, for example, an exposure affects an outcome, referring to the arrow's direction. Acyclic means that a pathway doesn't loop back, for instance going from exposure to confounder to outcome and back to exposure. And lastly, graph means there are some type of representation of real or hypothetical links between objects.

Another example of a DAG is a decision tree.

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

... Let's make a DAG of this {{3}}


`@part2`
&nbsp;

```{r}
confounders <- dagitty("dag {
  Height -> ColonCancer
  Sex -> {Height ColonCancer}
}") 
``` {{3}}

```{r}
adjustmentSets(
    confounders,
    exposure = "Height",
    outcome = "ColonCancer") 
``` {{4}}

```{r}
#>  { Sex }
``` {{4}}


`@script`
You can create DAGs with the dagitty package, which will then suggest possible adjustment variables. For example, let's study how height associates with risk for colon cancer. We know men tend to be taller than women, that men have a higher risk for cancer. This is a simple example, but assume we want to know, what do we adjust for? Let's use dagitty! The dagitty function takes a DAG specification as a character string. Starting with the keyword dag, we list each link between variables. Here, height links with colon cancer and sex links with both height and colon cancer. We then use the adjustmentSets function on the DAG, set the exposure and the outcome, and are told that sex should at least be adjusted for.

TODO: Describe adjustment set. Meaning of exposure, etc.


---
## Visualizing the graph from dagitty

```yaml
type: "FullSlide"
key: "d5d3441a67"
```

`@part1`
```{r}
plot(graphLayout(confounders))
``` {{1}}

![dagitty graph](https://assets.datacamp.com/production/repositories/2079/datasets/8af0f2c49f1e245a7cad1e0e19b53f1ccb987a13/ch3-v2-dagitty.png) {{2}}


`@script`
You can visualize what the graph looks like using this code to see how each variable is linked, as specified. Check this plot to confirm the DAG was correctly specified.


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
It is good practice to use multiple methods to decide what you should adjust. The information criterion methods are also quite powerful and compares several models to find which is better. The method balances model fitness with the number of predictors. Use the Akaike criterion or AIC for models that use maximum likelihood.


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
``` 
{{1}}

```{r}
# Logistic regression, all predictors
full_model <- glm(chd ~ ., data = cleaned_diet,
                  family = binomial, na.action = "na.fail") 
```
{{2}}

```{r}
# Models with every combination of predictor
model_comparison <- dredge(full_model, rank = "AIC", subset = "fibre")
```
{{3}}

- *A caution*: With many variables, big datasets, and/or the type of model = long computation times {{4}}


`@script`
You can use MuMIn as an interface to model selection. First, we must create a dataframe with the outcome and predictors, with no missingness. Then we create the model with all variables by using a dot after the tilde. MuMIn requires we set na dot fail. Next we use dredge on the model using AIC. Dredge runs all combination of models and compares them. In this example, our main exposure is fibre, so we set it with subset.

Be careful when running dredge. Since it compares many models, the computation time can be very long.

NOTE: You need to set na.action na fail because the dredge function requires it.


---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "276321afb5"
```

`@part1`
```{r}
head(model_selection, 4)
``` 
{{1}}

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
``` 
{{2}}


`@script`
To see the top four models, use head. The AIC column shows the models are all very similar. Here, we see that these variables may not contribute substantially to model fitness. We could be safe using any of these models.


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
Considering confounding is part of rigorous science. But it's also required from the STROBE checklist. STROBE, or strengthening the reporting of observational studies in epidemiology, and is internationally embraced by researchers working on observational studies. This checklist focuses your analyses and presentation of results and ensures adherence to higher quality research.

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
## Let's find some confounders!

```yaml
type: "FinalSlide"
key: "56b0010ae1"
```

`@script`
Alright, let's identify confounders!

