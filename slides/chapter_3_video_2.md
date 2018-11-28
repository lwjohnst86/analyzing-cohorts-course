---
title: "Adjustment, confounding, and model building"
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

In this lesson we will cover one of the trickier parts of the analysis, that is identifying and adjusting for potential confounders between the exposure and outcome. There are many ways of building a model to adjust for confounders. Whichever method you use, you need to rely on what others have done in previous studies and what the underlying biology is. This requires some domain specific knowledge, so make sure to collaborate with people who have that knowledge.

---
## Adhering to guidelines: STROBE Statement

```yaml
type: "FullSlide"
```

`@part1`

> The STROBE Statement: STrengthening the Reporting of OBservational studies in Epidemiology. www.strobe-statement.org

**Most journals require completion of STROBE checklist**, including to: {{1}}

> - *Describe any efforts to address potential sources of bias* {{2}}
> - *Describe all statistical methods, including those used to control for confounding* {{2}}
> - *Make clear which confounders were adjusted for and why they were included* {{2}}
> - *Give unadjusted estimates and ... confounder-adjusted estimates* {{2}}

`@script`

Before getting into model creating, we should touch on a key guideline for doing cohort analysis, which is the STROBE statement. STROBE stands for strengthening the reporting of observational studies in epidemiology. Your analyses and final presentation of results should be informed by this checklist. Besides it being the right thing to do to be thorough and careful during data analysis, this checklist forces you to think about specific things to at the minimum do. For instance, controlling for bias such as with confounding, why and how confounders were included and to include both unadjusted and adjusted results. Throughout the rest of the course, we will return to the STROBE checklist to help guide what we do and what we think about for doing cohort analyses.

---
## Creating models: Controlling for confounding

```yaml
type: "FullSlide"
```

`@part1`

- **Very difficult** to completely control for confounding
- Danger of not adjusting: Simpson's Paradox
    - Could lead to actual harm if not consider confounding
- Three common empirical and systematic approaches to identifying confounders:
    - Literature, biological rationale, background knowledge
    - Causal pathways: Directed acyclic graphs (DAG)
    - Model selection: Information criterion methods


`@script`

What does it mean to "adjust" for confounders? What is a confounder? You will have likely encountered confounding in one of the other epidemiology courses, so I won't cover it too much here. For cross-sectional analyses, adjusting for confounding is fairly easy, since there is no time-component. But in cohort datasets, confounding get a bit trickier and a little bit more thought needs to go into what to adjust for. And you are guaranteed to miss or not know about potential confounders. As the saying goes "All models are wrong, but some are useful".

Like all health research, considering confounders is very important. If you don't you may encounter a problem known as Simpson's Paradox, which we will cover in the next slide. There are several ways of identifying confounders. Some common and more appropriate methods include using previous knowledge of biology and of the problem, and using more formal mathematical methods such as directed acyclic graphs and information criterion techniques.

---
## An example of confounding: Simpson's paradox

```yaml
type: "FullSlide"
```

`@part1`

|Treatment |Success |
|:---------|:-------|
|A         |78%     |
|**B**         |**83%**     | {{1}}

&nbsp;

|Treatment |Kidney stone size |Success |
|:---------|:-----------------|:-------|
|**A**         |Large             |**73%**     |
|**A**         |Small             |**93%**     |
|B         |Large             |69%     |
|B         |Small             |87%     | {{2}}

&nbsp;

|Treatment |Kidney stone size | Successes| Total cases|
|:---------|:-----------------|---------:|-----------:|
|A         |Small             |        81|          87|
|**A**         |**Large**             |       192|         263|
|**B**         |**Small**             |       234|         270|
|B         |Large             |        55|          80| {{3}}

`@script`

Let's show a real life example of confounding and why it's important to consider them in the analysis. Here is a study of a two drugs on treating kidney stones. When we look at the total successes, we see that treatment B is better. But when we break it down by small and large kidney stones, we see that it reverses. Now treatment A is better for both large and small stones. How can that be? If we look at the absolute numbers, the paradox is revealed to occur because of ratios and totals. The treatment used depends on the severity of the case, which is judged and recommended by the doctor. This example highlights two things: Avoid only using percentages and the importance of searching for confounding factors.

---
## Classical definition of a confounder

```yaml
type: "FullSlide"
```

`@part1`

![DAG](datasets/ch3-v2-classic-confounder.png)

- This graphic is called a *directed acyclic graph*

`@script`

This simple graphic illustrates the classic definition of what a confounder is. In this case, a confounder is some variable that can influence both the outcome and the exposure, either hypothetically, biologically, or informed from data exploration. Understanding confounded relationships between variables is essential to making more accurate inferences about the association of investigation. Creating these causal graphs, known as directed acyclic graphs or DAGs, is a powerful method to confounder identification.

DAGs are a form of graph with nodes and edges. Here, the variables are the nodes and the causal hypothetical pathway between variables is the edge. A cause and an effect.

---
## Identifying adjustment variables with dagitty

```yaml
type: "TwoColumns"
```

`@part1`

Use an example: Height with colon cancer. But... {{1}}

- Men are taller {{2}}
- Men more likely to get cancer {{3}}
- Men tend to eat more meat {{4}}
- More meat, more likely to get colon cancer {{5}}

... Let's make a DAG of this. {{6}}

`@part2`

```{r}
possible_confounders <- dagitty("dag {
    Height -> ColonCancer
    Sex -> {Height ColonCancer}
    Sex -> MeatIntake -> ColonCancer
}") {{7}}

adjustmentSets(possible_confounders,
               exposure = "Height",
               outcome = "ColonCancer") {{8}}
#>  { Sex } {{9}}
```

`@script`

Using the R package dagitty, you can create DAGs of possible confounders and dagitty will suggest potential adjustment variables. Let's take this example here. We want to study the association between height and risk for colon cancer. But, we know that men tend to be taller than women, that men tend to have a higher risk for cancer, that men tend to eat more meat, and that meat intake increases risk for colon cancer. So what do we need to adjust for? Both sex and meat intake? Let's draw a DAG with dagitty to find out! The first argument for the dagitty function takes a character string of a DAG specification. We initialise with the keyword dag, and afterward list each corresponding link between variables. Here, height links with colon cancer, sex links with both height and colon cancer, and so on until all links are drawn. Then we use the adjustmentsets function, add the dagitty object, then we set which variable is the exposure and which is the outcome. After we run this, we get told that we need to adjust for at least sex. The dagitty package is very useful when you start getting more complicated pathways.

---
## Assessing model fit: Information criterion methods

```yaml
type: "FullSlide"
```

`@part1`

- Estimates relative model "quality" compared to other models. {{1}}
- Trade-off between the goodness of fit and simplicity (number of predictors). {{2}}
- Common method: Akaike information criterion (AIC). {{3}}
    - For models that use maximum likelihood (most regression-based methods).

`@script`

While the use of DAGs is a powerful tool to identifying potential confounders, I strongly recommend against using just one method to building a model. The main reason being is that you may not know all the potential links to include in the DAG. Another useful technique is the information criterion methods, which compare which of several models is better than the others. The comparison is based on a trade-off between model fitness and the number of predictors. One commonly used method is the Akaike criterion or AIC, when comparing models that use maximum likelihood (most regression type methods).

---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
```

`@part1`

```{r}
# Keep only interested predictors and no missing
cleaned_diet <- diet %>%
    mutate(bmi = weight / (height / 100)^2) %>%
    select(energy, bmi, fat, fibre, chd) %>%
    na.omit() {{1}}

# Logistic regression, all predictors
full_model <- glm(chd ~ ., data = cleaned_diet,
                  family = binomial, na.action = "na.fail") {{2}}

# Models with every combination of predictor
model_comparison <- dredge(full_model, rank = "AIC", subset = "fibre") {{3}}
```

&nbsp;

- *Caution*: Too many variables, big dataset, and/or type of model will result in long computation time {{4}}
- **Don't** rely on *only* this method for model building {{5}}

`@script`

The MuMIn package implements an easy interface to model selection. There are a couple steps we need to do before comparing models. First, we need to create a dataframe with only the outcome and other variables of interest that would be in the model. Then we need to remove all missing values. Second, we create the model object with all variables included in the model, which the period after the tilde represents. We are doing a logistic regression, hence why we have a binomial family. We also have to set na dot fail, since MuMIn requires it. Third, we use the dredge function with the model object, using AIC. We can tell dredge that every model it compares must have the variable fibre.

A couple of comments. Because dredge creates models of very combination of predictor, if you have many variables, a big dataset, or a complicated method R may have very long computation times. So be careful. Also, do not rely on only this method. You need to use multiple techniques to decide on what variables to adjust for.

---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
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

Let's see the top four models using head. We see from the AIC column that the models are all very similar, no matter what variable is included in the model. This may tell us a few things, mainly that these variables don't contribute substantially to improving model fit. So in this case, we could be fairly safe at using any of these models and still maintain a good model fit.

---
## Let's find some confounders!

```yaml
type: "FinalSlide"
```

`@script`

Alright, let's get to identifying potential confounders!
