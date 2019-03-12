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

---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
```

`@part1`
An example: Height with colon cancer. {{1}}


`@part2`

```{r}
confounders <- dagitty("dag {
  Height -> ColonCancer

}") 
``` {{2}}

```{r}
plot(graphLayout(confounders))
``` {{3}}

![dagitty graph](https://assets.datacamp.com/production/repositories/2079/datasets/ffd2d6db1ded2c0cdd212531e3393f1f4c2bba6a/ch3-v2-dagitty-1.png) {{3}}

`@script`

So how do we use DAGs to find confounders? Let's do an example, where we are determining whether height is associated with colon cancer. 

We can use the dagitty package to create DAGs by giving it a character string of a DAG specification. This string begins with the name dag then curly brackets followed by the variable names and links. Links are indicated using the arrow, which is the minus and greater than sign.

We can plot it by wrapping the DAG object with graph layout, which gives us a nice DAG image.

---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
disable_transition: true
```

`@part1`
An example: Height with colon cancer. 

But... 

- Men are taller {{1}}
- Men more likely to get cancer {{1}}


`@part2`

```{r}
confounders <- dagitty("dag {
  Height -> ColonCancer
  Sex -> {Height ColonCancer}
}") 
``` {{2}}

```{r}
plot(graphLayout(confounders))
``` {{3}}

![dagitty graph](https://assets.datacamp.com/production/repositories/2079/datasets/dcfb3d855caa09046ddacc5dcc13a707736dfa87/ch3-v2-dagitty-2.png) {{3}}


`@script`

But we know there are confounding factors to this association. First, we know that men tend to be taller and than men are more likely to get cancer. 

We include that in the DAG by creating another line and setting additional links. Because sex is linked with both height and cancer, in the DAG string we can include both by wrapping them in curly brackets.

When we plot the DAG, we see how the DAG looks like.

---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
disable_transition: true
```

`@part1`
An example: Height with colon cancer.

But... 

- Men are taller 
- Men more likely to get cancer


`@part2`

```{r}
confounders <- dagitty("dag {
  Height -> ColonCancer
  Sex -> {Height ColonCancer}
}") 
```

```{r}
adjustmentSets(
    confounders,
    exposure = "Height",
    outcome = "ColonCancer"
) 
``` {{1}}

```{r}
#>  { Sex }
``` {{2}}


`@script`

The important part of using DAGs isn't in making nice figures, it's to determine what variables to adjust for in the model. We can use the adjustment sets function, which determines possible variables to adjust for to reduce the risk of confounding bias. Since a DAG doesn't know which variables are the exposure and outcome, we need to include that by setting those respective arguments.

Since this particular example is very simple, the only variable we should control for is sex.

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
It is good practice to use multiple methods to decide what you should adjust. The information criterion methods are also quite powerful and compare several models to find which is better. The method balances model fitness with the number of predictors. Use the Akaike criterion or AIC for models that use maximum likelihood.


---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "51eddc42eb"
```

`@part1`

```{r}
full_model <- glmer(
    got_cvd ~ body_mass_index_scaled + total_cholesterol_scaled +
        participant_age + currently_smokes + education_combined +
        sex + (1 | subject_id), 
    data = tidied_framingham, family = binomial, na.action = "na.fail")
```
{{1}}

```{r}
library(MuMIn)
# Models with every combination of predictor
model_selection <- dredge(full_model, rank = "AIC",
                          subset = "total_cholesterol_scaled")
```
{{2}}

- *A caution*: With many variables, big datasets, and/or the type of model = long computation times {{4}}

`@script`
We can use the MuMIn package for model selection. To start, we need to add all the variables to the model that we think might contribute or confound the association between the outcome and the exposure. We need to set na dot action to na dot fail, as it is required for the MuMIn function.

Then we give the full model to the dredge function from MuMIn. Dredge is useful as it runs models of all possible combinations of variables that is included in the original full model. Dredge requires the model object and which model ranking method to use to determine which is the best model, in this case using AIC. You can also specify that you only want models compared that at least have the cholesterol variable by using the subset argument.

Be careful when running dredge. Since it compares many models, the computation time can be very long if you include too many variables or use complex model techniques.

---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "276321afb5"
```

`@part1`
```{r}
# Top 5 models
head(model_selection, 5)
``` 
{{1}}

```
Global model call: glmer(formula = got_cvd ~ body_mass_index_scaled + total_cholesterol_scaled + 
    participant_age + currently_smokes + education_combined + 
    sex + (1 | subject_id), data = tidied_framingham, family = binomial, 
    na.action = "na.fail")
---
Model selection table 
     (Int) bdy_mss_ind_scl crr_smk edc_cmb prt_age sex ttl_chl_scl df   logLik   AIC delta weight
58 -1.2190          0.7495                  0.5155   +      0.2742  6 -203.065 418.1  0.00  0.411
60 -1.5220          0.7653       +          0.5859   +      0.2709  7 -202.288 418.6  0.44  0.329
50 -1.2580          0.7356                           +      0.2749  5 -205.457 420.9  2.78  0.102
62 -0.9683          0.7212               +  0.4928   +      0.2804  8 -202.588 421.2  3.05  0.090
64 -1.2870          0.7401       +       +  0.5603   +      0.2742  9 -201.854 421.7  3.58  0.069
Models ranked by AIC(x) 
Random terms (all models): 
‘1 | subject_id’
``` 
{{2}}


`@script`
To determine which variables should be included based on dredge, use head to show the top models. In this case, we are showing the top 5 models. 

The output of dredge shows many things, such as the model information at the top, then shows a table of models compared, including or excluding certain variables. Notice how some columns don't have a value in the cell. This indicates the model excluded that variable. The AIC is listed at the end, along with the delta, or difference with the last model AIC. The last column is weight and that tells us the likelihood that that model is better than the others. So we can see that the first two models are vary similar in AIC and weight. Based on the output from dredge, a model with body mass, age, and sex, and optionally smoking status, would have the best model fit of the models compared.


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
## Let's find some confounders!

```yaml
type: "FinalSlide"
key: "56b0010ae1"
```

`@script`
Alright, let's identify confounders!

