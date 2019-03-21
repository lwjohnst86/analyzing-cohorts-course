---
title: Testing for interaction and sensitivity analyses
key: db8d5c421cb76b9e5a85f8e22cd5dcb0

---
## Testing for interaction and sensitivity analyses

```yaml
type: "TitleSlide"
key: "41a97651b5"
```

`@lower_third`

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
An important part of any cohort analysis is testing for interactions of variables and running sensitivity analyses.


---
## Interaction: Combining variables in a model

```yaml
type: "FullSlide"
key: "fe20e41d30"
```

`@part1`
- **Interaction testing**: Check if a variable modifies another variable's association on the outcome {{1}}
    - E.g. A drug reduces risk of a disease in men, but not women {{1}}
    - E.g. Greater risk for disease from obesity in some ethnicities {{1}}
    - *Always* consider sex and ethnic ancestry {{2}}


`@script`
Interaction testing is when you combine variables in a model to see whether their individual values together modify the association with an outcome. For example, some drugs reduce risk for disease in men, but may be harmful or have no effect in women. Or that risk factors such as obesity have a larger effect in certain ethnicities. For sex and ethnicity, you should always check for interactions, as they have powerful impacts on health.


---
## Several approaches to checking interactions

```yaml
type: "FullSlide"
key: "a2abb2e2ae"
```

`@part1`
- Visual inspection {{1}}
    - Very effective
- Stratified/subgroup analysis {{2}}
    - Split dataset based on group
    - Do separate analysis on splits
- Formal test for interaction {{3}}
    - Model possible differences


`@script`
There are several ways to check for interactions. The first, and often most effective, is to visualize the data. More formal methods include doing stratified analyses, by splitting up the dataset. You can also directly model interactions using interaction terms in your analyses.


---
## Modeling differences using interaction terms

```yaml
type: "FullSlide"
key: "39623125fa"
```

`@part1`
**Interaction terms using R formula**: {{1}}

```
outcome ~ predictor + sex + predictor:sex
``` 
{{1}}

**Simplified version in formula**: {{2}}

```
outcome ~ predictor * sex
``` 
{{2}}

- Can't interpret estimates on their own {{3}}


`@script`
There are several ways to model interactions. One way is similar to mathematically writing it out, with the predictor colon sex specifying the interaction. However, you can also use a shorthand with the asterisk between the two terms. These two formula are equivalent.


---
## Running a model with an interaction

```yaml
type: "FullSlide"
key: "c46f536e01"
```

`@part1`
```{r}
model_with_interaction <- glmer(
    got_cvd ~ body_mass_index_scaled * sex + (1 | subject_id),
    data = tidied_framingham, family = binomial)
summary(model_with_interaction)
```
{{1}}

```
Generalized linear mixed model fit by maximum likelihood (Laplace Approximation)
Fixed effects:
                                Estimate Std. Error z value Pr(>|z|)    
(Intercept)                     -12.3403     0.3203 -38.530   <2e-16 ***
body_mass_index_scaled            0.1272     0.2681   0.475   0.6351    
sexWoman                         -0.9423     0.3696  -2.549   0.0108 *  
body_mass_index_scaled:sexWoman   0.1672     0.3412   0.490   0.6241    <-- This
```
{{2}}

- Interaction interpretation is difficult and complex {{3}}
	- Refer to [Statistical Modeling in R (Part 2)](https://www.datacamp.com/courses/statistical-modeling-in-r-part-2) course


`@script`
Here is a mixed model interaction using the Framingham dataset. We are testing the interaction between scaled body mass index and sex. Notice the asterisks to denote the interaction. 

The model summary gives a lot of information, most of which I've cut to show the main fixed effects. With interactions we can't interpret using just one estimate as we would with no interactions. We must use the estimates from each of the interaction terms, which are the three estimates from this model. 

Interpreting interaction results can be quite difficult. If you encounter interactions in your own modeling or want to learn more, check out Chapter 1 of the Statistical Modeling in R Part Two DataCamp course, which describes model interactions in great detail.


---
## Checking if an interactive association exists

```yaml
type: "FullSlide"
key: "ee31140a86"
```

`@part1`
```{r}
library(MuMIn)
model_no_interaction <- glmer(
    got_cvd ~ body_mass_index_scaled + sex + (1 | subject_id),
    data = tidied_framingham, family = binomial)
model_with_interaction <- glmer(
    got_cvd ~ body_mass_index_scaled * sex + (1 | subject_id),
    data = tidied_framingham, family = binomial)

# Compare models
model.sel(model_no_interaction, model_with_interaction, rank = "AIC")
```

```
Model selection table 
                       ...    logLik      AIC    delta    weight
model_no_interaction   ... -1822.493 3652.985 0.000000 0.7069518 <-- Here
model_with_interaction ... -1822.373 3654.746 1.761251 0.2930482
Models ranked by AIC(x) 
```
{{1}}


`@script`
To determine if an interaction does exist, you need to compare models with and without an interaction using the model dot sel function. The function accepts many models as arguments. It also takes the method to rank with, which we'll use AIC. It is a measure tries to balance the model's fit to the data and the number of predictors. A smaller AIC means the model is better compared to a larger AIC.

Running the function outputs several columns. The important ones are AIC, delta, and weight. The interaction model's delta is two more AIC, indicating it is slightly worse, while the no interaction model's weight value tells us that it is seventy percent more likely better. This tells us that including an interaction gives no additional information, so we can remove it.


---
## Checking robustness of results with sensitivity analyses

```yaml
type: "FullSlide"
key: "a0da496622"
```

`@part1`
> Sensitivity analysis: "assess the robustness of association by checking change in results by changing assumptions"

- Very common in epidemiology
- Examples: {{1}}
    - Are people who miss collection visits different from others?
    - Does the statistical technique change results?


`@script`
Sensitivity analysis is a way to determine how robust your results are under different assumptions.

Examples include whether people who miss the data collection visit are different or if the results change with a different statistical technique.


---
## Example: Previous diabetes increases risk of CVD

```yaml
type: "FullSlide"
key: "3fbf27f005"
```

`@part1`
```{r}
no_diabetes_framingham <- tidied_framingham %>%
    filter(diabetes == 0)

glmer(got_cvd ~ body_mass_index_scaled + (1 | subject_id),
      data = tidied_framingham, family = binomial) %>%
    fixef()
#>           (Intercept) body_mass_index_scaled 
#>             -12.86217                0.23932 
``` 
{{1}}

```{r}
glmer(got_cvd ~ body_mass_index_scaled + (1 | subject_id),
      data = no_diabetes_framingham, family = binomial) %>%
    fixef()
#>           (Intercept) body_mass_index_scaled 
#>           -12.8966567              0.2529004 
``` 
{{2}}


`@script`
Here's an example. Individuals with diabetes have a much higher risk of developing CVD because of toxicity from high blood glucose. Depending on the predictor, including diabetes cases may bias the estimates so removing them may be needed. So we run a model that excludes participants with diabetes and one with diabetes cases, then output the fixed effect estimates for both.

The estimate for BMI in the model without diabetes cases is slightly higher than the estimate that includes diabetes cases. This suggests that diabetes cases may be reducing the estimate. However, the differences are very small, so if there is bias it isn't large.


---
## Time to practice!

```yaml
type: "FinalSlide"
key: "1931fc9890"
```

`@script`
Alright, let's do some exercises!

