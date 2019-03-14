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
title: Postdoctoral researcher in diabetes epidemiology


`@script`
An important part of any analysis is testing for interactions of important variables and running sensitivity analyses.


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
Interaction testing is when you combine variables in a model to see whether their individual values together modify the association with an outcome. For example, some drugs reduce risk for a disease in men, but may be harmful or have no effect in women. Or that risk factors such as obesity have a larger effect in certain ethnicities. When it comes to sex and ethnicity, you always need to check for interactions, since both have such powerful impacts on health.


---
## Several approaches to checking interactions

```yaml
type: "FullSlide"
key: "a2abb2e2ae"
```

`@part1`
- Visual presentation {{1}}
    - Very effective
- Stratified/subgroup analysis {{2}}
    - Split dataset based on group
    - Do separate analysis on splits
- Formal test for interaction {{3}}
    - Model possible differences


`@script`
There are several ways to check for interactions. The first, and often the most effective, is to visualize the data. More formal methods include doing stratified analyses, which is literally splitting the dataset up by a group such as sex. You can also directly model interactions by including interaction terms in your analyses.


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
There are several ways to model an interaction term. One way is similiar to mathematically writing it out, with the predictor colon sex specifying the interaction. However, you can also use a shorthand using the asterisk between the two terms. These two formulas are equivalent. Be careful with the estimates, as you cannot interpret interaction estimates alone but only in the context of the other estimates.


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

Parts of output: {{2}}

```
Generalized linear mixed model fit by maximum likelihood (Laplace Approximation)

... # Removed parts

Fixed effects:
                                Estimate Std. Error z value Pr(>|z|)    
(Intercept)                     -12.3403     0.3203 -38.530   <2e-16 ***
body_mass_index_scaled            0.1272     0.2681   0.475   0.6351    
sexWoman                         -0.9423     0.3696  -2.549   0.0108 *  
body_mass_index_scaled:sexWoman   0.1672     0.3412   0.490   0.6241    <-- This
...
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

...
```
{{2}}


`@script`
Here we show a mixed model interaction using the Framingham dataset. We test the interaction between scaled body mass index and sex. Notice the use of the asterisks to denote the interaction. 

When we run summary on the model, it gives us a lot of information. I've cut out some of that info to focus on the main results of the fixed effects. With interactions, we can't interpret the estimates as we do normally. We need to interpret all estimates from the interaction terms, in this case there are the three estimates. The interaction estimate itself is showing that when sex is female and body mass index is 1 unit or standard deviation, then the combined estimate is plus zero point sixteen. But in this case, the standard error for the interaction is very wide, suggesting that there isn't much interactive effect going on.

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
model.sel(model_no_interaction, model_with_interaction, rank = "AIC")
```

```
Model selection table 
                       ...    logLik      AIC    delta    weight
model_no_interaction   ... -1822.493 3652.985 0.000000 0.7069518 <--
model_with_interaction ... -1822.373 3654.746 1.761251 0.2930482
Models ranked by AIC(x) 
```
{{1}}


`@script`
To determine whether there is an interaction, you'll need to compare models with and without the interaction by using the model dot sel function. Here the difference between models in their AIC is almost two, shown in the delta. The weight value tells us that the no interaction model is likely the better of the two models by seventy percent. This tells us there is minimal difference in the models, so it isn't likely there is an interaction present.

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
Sensitivity analysis is a way to determine the robustness of your results by checking different assumptions that may change your results.

Examples of this include whether people who miss the data collection visit are different or if the results you obtain differ because of a statistical technique.


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
Here's an example. When individuals have diabetes they are at much higher risk of developing cardiovascular disease because of a range physiological changes that occur because of the diabetes. Depending on the predictor, including diabetes cases may bias the estimates so removing them may be needed. So here we keep only those participants without diabetes. Then we run the model on the original dataset and output the fixed effect estimates.

Next we run the model on the data without the diabetes cases, again outputting the fixed effect estimates. See how this estimate is slightly higher than the estimates found from original dataset. The estimate is slightly higher, suggesting diabetes cases may be reducing the estimate. However, the differences are very small, so if there is some bias it isn't large.

---
## Time to practice!

```yaml
type: "FinalSlide"
key: "1931fc9890"
```

`@script`
Let's do some exercises!

