---
title: Adjustment, confounding, and model building
key: 911feb6e308d8e7e180f7f33f32a51ed

---
## Adjustment, confounding, and model building

```yaml
type: "TitleSlide"
key: "a68d4805ba"
```

`@lower_third`

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
A difficult part of doing analysis is controlling for potential confounders.


---
## Classical definition of a confounder

```yaml
type: "FullSlide"
key: "24393effa1"
```

`@part1`
![Confounder](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)


`@script`
What is a confounder? It is a variable that could influence both the outcome and exposure. While you may have learned about confounding in other courses, understanding it is essential to making valid inferences.


---
## Creating models: Controlling for confounding

```yaml
type: "FullSlide"
key: "b9a8c843aa"
```

`@part1`
- Completely controlling for confounding is **very difficult**
- Integral to STROBE statement: **STrengthening the Reporting of OBservational studies in Epidemiology.** (www.strobe-statement.org) {{1}}
- Three common approaches: {{2}}
    - Literature, biological rationale, background knowledge
    - Causal pathways: Directed acyclic graphs (DAG)
    - Model selection: Information criterion methods


`@script`
You control for confounding by including them in your models, reducing risk of biased estimates. Adequately adjusting for confounding requires considerable thought and effort. Do the best you can, but know that you'll never adjust for everything.

Confounder adjustment is part of thorough research, and is so important that it's part of the STROBE statement best practices. STROBE, or strengthening the reporting of observational studies in epidemiology, is a standard for cohort research and should be adhered to.

Use several approaches to identify confounders, as each have strengths and weaknesses. Use biological and domain knowledge and formal methods like directed acyclic graphs, called DAGs, and information criterion techniques.


---
## Identify confounders with Directed Acyclic Graphs (DAG)

```yaml
type: "FullSlide"
key: "7aadf2f281"
```

`@part1`
![DAG](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)

- Directed = A link with an arrow/direction {{1}}
- Acyclic = No looping (cycling) backward {{2}}
- Graph = Representation of objects and links {{3}}


`@script`
DAGs provide a powerful approach to finding confounders as it makes hypothetical pathways explicit.

What does DAG mean? Directed indicates directionality: a cause and effect. Acyclic means that a pathway doesn't loop backward: the effect can't also cause the cause. Lastly, graph is a visual representation of links between objects.


---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
key: "079ffc1532"
```

`@part1`
An example: Height with colon cancer {{1}}


`@part2`
```{r}
confounders <- dagitty("dag {
  Height -> ColonCancer

}") 
``` 
{{2}}

```{r}
plot(graphLayout(confounders))
``` 
{{3}}

![dagitty graph](https://assets.datacamp.com/production/repositories/2079/datasets/bac11416364a6c926095a672a1b60ee6dacf546f/ch3-v2-dagitty-1.png) {{3}}


`@script`
Here's an example of using DAGS. Let's say we want to determine whether height associates with colon cancer. 

We can use the dagitty package to help out. We give it a character string of a DAG specification. This string begins with the name dag, then curly brackets, followed by the variable names and links. Write links with the minus and greater than sign.

We plot it with graph-underscore-layout to get a nice image.


---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
key: "5db74f1cb6"
disable_transition: true
```

`@part1`
An example: Height with colon cancer

But... 

- Men are taller {{1}}
- Men more likely to get cancer {{1}}


`@part2`
```{r}
confounders <- dagitty("dag {
  Height -> ColonCancer
  Sex -> {Height ColonCancer}
}") 
``` 
{{2}}

```{r}
plot(graphLayout(confounders))
``` 
{{3}}

![dagitty graph](https://assets.datacamp.com/production/repositories/2079/datasets/a2fceb013a9fdd1946aca1b17bf89ebb1854f1cb/ch3-v2-dagitty-2.png) {{3}}


`@script`
But, we know there are confounders. We know men tend to be taller and men are more likely to get cancer. 

We can add these links into dagitty. Since sex is linked with both height and cancer, we include both by wrapping them in curly brackets.

Plotting it shows the links we've added.


---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
key: "c995819382"
disable_transition: true
```

`@part1`
An example: Height with colon cancer

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
```
{{1}}

```{r}
#>  { Sex }
``` 
{{2}}


`@script`
The point of dagitty isn't for figures, it's to find the variables to adjust for. The adjustment sets function tells us which variables at a minimum to adjust for. For this to work, we need to specify which variables are the exposure and outcome.

For this simple example, only sex is a possible confounder.


---
## Assessing model fit: Information criterion methods

```yaml
type: "FullSlide"
key: "fa35c1a27a"
```

`@part1`
- Estimates relative model "quality" over others {{1}}
- Trade-off between goodness of fit and number of predictors {{2}}
- Common method: Akaike information criterion (AIC) {{3}}
    - For maximum likelihood models
    - Smaller number, the better


`@script`
Another method is information criterion, which identifies adjustment variables by comparing multiple models. A common method is the Akaike criterion or AIC, where a smaller number is better.


---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "640d4015fb"
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

- *A caution*: With many variables, big datasets, and/or the type of model = long computation times {{3}}


`@script`
The MuMIn package has model selection functions like dredge. Dredge needs a model with all variables we think may bias the estimate, and needs the argument na dot action set to na dot fail.

We then give the model to dredge, which runs models with all possible variable combinations. We need to set the method to rank models, for us it is AIC. We'll also specify that only models with at least cholesterol be compared by using the subset argument.

Be careful though, computation times can become very long.


---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "4bdd8bc787"
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
...
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
Use head to show the top 5 models from dredge.

Dredge outputs a lot. The cells with missing values are the models without those variables. The delta and weight columns on the end tell us which models are the better ones. The delta is the difference in AIC with the model above. Weight is the likelihood we should choose that model of all models. Here, adding body mass, age, and sex, and optionally smoking, would provide a good fit for the model.


---
## Let's find some confounders!

```yaml
type: "FinalSlide"
key: "6c254e2fc3"
```

`@script`
Alright, let's identify confounders!

