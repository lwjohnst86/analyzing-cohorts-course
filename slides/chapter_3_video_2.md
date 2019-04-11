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
A difficult part of doing cohort analyses is controlling for potential confounders.


---
## Classical definition of a confounder

```yaml
type: "FullSlide"
key: "24393effa1"
```

`@part1`
![Confounder](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)


`@script`
What is a confounder? It is a variable that could influence both the exposure and outcome. While you may have learned about confounding in other courses, understanding it is essential to making valid inferences.


---
## Creating models: Controlling for confounding

```yaml
type: "FullSlide"
key: "b9a8c843aa"
```

`@part1`
- Completely controlling for confounding is **very difficult**
- STROBE statement on best practices: **STrengthening the Reporting of OBservational studies in Epidemiology.** (www.strobe-statement.org) {{1}}
- Three common approaches: {{2}}
    - Literature, biological rationale, background knowledge
    - Causal pathways: Directed acyclic graphs (DAG)
    - Model selection: Information criterion methods


`@script`
You control for confounding by including them in your models. Adequately adjusting for confounding requires much consideration. Do the best you can, but know that you'll never adjust for everything.

Confounder adjustment is part of any thorough research and is part of the STROBE statement on best practices. STROBE, or Strengthening the Reporting of Observational Studies in Epidemiology, is a standard in cohort research and should be adhered to.

We should use several approaches to identify confounders, as each have strengths and weaknesses. Use biological and domain knowledge and formal methods like directed acyclic graphs, called DAGs, and information criterion techniques.


---
## Identify confounders with Directed Acyclic Graphs (DAG)

```yaml
type: "TwoColumns"
key: "8d4cda23ef"
```

`@part1`
![DAG](https://assets.datacamp.com/production/repositories/2079/datasets/2d3a0b3b5a2f6f084658a87f5d942bc77d9fe28f/ch3-v2-classic-confounder.png)


`@part2`
- Directed = A link with an arrow/direction {{1}}
- Acyclic = No looping (cycling) backward {{2}}
- Graph = Representation of objects and links {{3}}


`@script`
DAGs make hypothetical causal links explicit and provide a powerful approach to finding confounders.

Let's break the name down. Directed indicates directionality: cause and effect. Acyclic means that a pathway doesn't loop backward: the effect can't also cause the cause. Lastly, graph is a visual representation of links between objects.


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
Here's an example of using DAGs. Let's say we want to determine if height associates with colon cancer.

We can use the dagitty package to help find confounders. We give it a character string of a DAG specification. This string begins with the name dag, then curly brackets, followed by hypothetical variable names and links. Write links with the minus and greater than sign.

We plot it using the graph-layout function.


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

We then add these links into dagitty. Since sex is linked with both height and cancer, we include both by wrapping them in curly brackets.

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
dagitty is used mainly to help with causal reasoning and to decide what to include in our models. The adjustment sets function tells us which variables at a minimum we should adjust for. In the function we need to set the exposure and outcome arguments.

This is a simple example, but it says we should at least adjust for sex.


---
## Assessing model fit: Information criterion methods

```yaml
type: "FullSlide"
key: "fa35c1a27a"
```

`@part1`
- Estimates relative model "quality" over others {{1}}
- Trade-off between goodness of fit and number of predictors {{1}}
- Common method: Akaike information criterion (AIC) {{2}}
    - For maximum likelihood models
    - Smaller number, the better


`@script`
Another method is information criterion, which identifies adjustment variables by comparing multiple models' fitness. Akaike criterion or AIC ranking is commonly used. A smaller AIC is better.


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
The MuMIn package has model selection functions like dredge. Dredge needs a model with all variables we think may bias the results. The argument na dot action set to na dot fail must be set.

We give the model object to dredge to run models with all possible variable combinations. We'll use AIC in the rank argument and specify with the subset argument that we want models with at least cholesterol included.

A quick warning, computation times can become very long if you're not careful.


---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
key: "4bdd8bc787"
```

`@part1`
```{r}
# Top 3 models
as.data.frame(model_selection) %>%
    head(3)
``` 
{{1}}

```
   (Intercept) body_mass_index_scaled currently_smokes
57   -1.218899              0.7494514             <NA>
59   -1.522049              0.7652833                +
49   -1.258198              0.7356253             <NA>
   education_combined participant_age sex total_cholesterol_scaled
57               <NA>       0.5155339   +                0.2742008
59               <NA>       0.5858787   +                0.2709116
49               <NA>              NA   +                0.2748649
   df    logLik      AIC     delta     weight
57  6 -203.0653 418.1307 0.0000000 0.36560377
59  7 -202.2876 418.5751 0.4444555 0.29275100
49  5 -205.4571 420.9143 2.7836167 0.09089835
``` 
{{2}}


`@script`
To show the top three models, we first convert the dredge object to a dataframe and use head with three.

Dredge outputs several columns, with each row as a model. Rows with missing values in the columns for the variable names indicate they were not included in the model. The delta and weight columns indicate which models are the relatively better. The delta is the difference in AIC to the model above. Weight is the likelihood that we should choose that model. 

The top model adjusts for body mass, age, and sex.


---
## Let's find some confounders!

```yaml
type: "FinalSlide"
key: "6c254e2fc3"
```

`@script`
Alright, let's identify confounders!

