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
title: Instructor


`@script`
Let's discuss testing for interactions and running sensitivity analyses.


---
## Considering the role of sex and ethnicity

```yaml
type: "FullSlide"
key: "fe20e41d30"
```

`@part1`
- A bit of history on role of sex {{1}}
    - Most health or drug studies had only men
    - Assumed equal response in women
    - Not true, e.g. some drugs harmful in women
- Ethnic ancestry also influential on health {{2}}
    - Most studies only in European-ancestry
    - But differences exist
- *Always* consider sex and ethnic ancestry {{3}}


`@script`
First, a bit of history. In the past many studies only include men, but not women. At the time, women were thought to respond equally to men for health and drug interventions, which isn't the case. In fact, some drugs were harmful to women but not to men. Likewise, ethnic ancestry can have very strong influences on whether an intervention will help or harm. Even still, most studies are done on European-ancestries. But we know differences exist between ancestries that could lead to major differences in reaction to treatments. So you always need to think about and analyze for differences between sex and ethnicity.


---
## Several approaches to checking differences

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
- Test for interaction {{3}}
    - Model possible differences


`@script`
There are several ways to check differences. The first, and often the most effective, is to visualize the differences. More formal methods include doing stratified analyses, which is literally splitting the dataset up by group. You can also directly model differences by including interaction terms in your analyses.


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
``` {{1}}

**Simplified version in formula**: {{2}}

```
outcome ~ predictor * sex
``` {{2}}

- Can't interpret estimates on their own {{3}}


`@script`
There are two ways to model an interaction term. The first is similiar to mathematically writing it out, with the predictor colon sex specifying the interaction. However, you can use a shorthand using the asterisk between the two terms. These two formulas are equivalent. Be careful with the estimates. You cannot interpret interaction estimates alone but only in the context of the other estimates.


---
## Running a model with an interaction

```yaml
type: "FullSlide"
key: "c46f536e01"
```

`@part1`
```{r}
with_interaction <- glm(chd ~ weight * energy.grp,
                        data = diet, family = binomial)
summary(with_interaction)
```


```
Call:
glm(formula = chd ~ weight * energy.grp, family = binomial, data = diet)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-0.6430  -0.6254  -0.4968  -0.3889   2.3273  

Coefficients:
                              Estimate Std. Error z value Pr(>|z|)
(Intercept)                  -1.627930   1.289080  -1.263    0.207
weight                        0.001478   0.018140   0.081    0.935
energy.grp>2750 KCals         2.492756   2.375240   1.049    0.294
weight:energy.grp>2750 KCals -0.043461   0.032994  -1.317    0.188
``` {{1}}


`@script`
Ok, here's an example. This dataset doesn't have sex or ethnicity, so we'll use the energy group variable. You'll notice it isn't much more difficult to run an interaction test, as you just include the asterisk. But! The estimates are very different. There is now another term for weight with energy group at the bottom. Later in the course we'll get to interpretation.


---
## Checking if interactive association exists

```yaml
type: "FullSlide"
key: "ee31140a86"
```

`@part1`
```{r}
library(MuMIn)
no_interaction <- glm(chd ~ weight + energy.grp,
                      data = diet, family = binomial)
with_interaction <- glm(chd ~ weight * energy.grp,
                        data = diet, family = binomial)
model.sel(no_interaction, with_interaction, rank = "AIC")
```

```
Model selection table 
                   (Int) enr.grp    wgh enr.grp:wgh df   logLik   AIC delta
no_interaction   -0.6758       + 0.5299              3 -129.305 264.6  0.00
with_interaction -1.6280       + 0.4701           +  4 -128.425 264.8  0.24
Models ranked by AIC(x) 
``` {{1}}


`@script`
Great, we've ran a model with an interaction. But how do we know whether an interaction exists or not. We can test it by seeing if the model fitness improves. Here we use the model dot sel function from MuMIn. Run two models, one with and one without the interaction. Then compare the two models for their AIC. You'll see in the output that in this case the two models are equivalent. That tells us that since including an interaction doesn't give more information, we can say there is no interaction.


---
## Checking robustness of results with sensitivity analyses

```yaml
type: "FullSlide"
key: "a0da496622"
```

`@part1`
> Sensitivity analysis: "assessing the robustness of an association by checking whether changing any of the assumptions might lead to different results or interpretations"

- Very common in epidemiology
- Examples: {{1}}
    - Are people who miss data collection different from others?
    - Does the statistical technique change results?


`@script`
In epidemiology we also often do sensitivity analyses, which is a series of additional analyses assessing the robustness of your results by checking different assumptions that may change your results.

For example, maybe you want to determine whether people who miss the data collection visit are somehow different. Or maybe the result is due to the specific statistical technique, so you redo the analysis with a slightly different technique.


---
## Example: Under and over estimating dietary intake

```yaml
type: "FullSlide"
key: "3fbf27f005"
```

`@part1`
- Run analysis with more plausible dietary energy intake

```{r}
remove_diet_misreporting <- diet %>%
    filter(between(energy, 20, 40))

summary(glm(chd ~ weight + energy, data = diet,
            family = binomial))$coef

#>                 Estimate Std. Error    z value    Pr(>|z|)
#> (Intercept)  1.795997723 1.35969917  1.3208787 0.186541801
#> weight      -0.007172747 0.01515672 -0.4732386 0.636042947
#> energy      -0.113894418 0.04197572 -2.7133404 0.006660865
``` {{1}}

```{r}
summary(glm(chd ~ weight + energy, data = remove_diet_misreporting,
            family = binomial))$coef

#>                Estimate Std. Error    z value   Pr(>|z|)
#> (Intercept)  1.59669111 1.50476475  1.0610902 0.28864892
#> weight      -0.01049956 0.01601857 -0.6554621 0.51217026
#> energy      -0.09831964 0.04744248 -2.0723968 0.03822845
``` {{2}}


`@script`
Let's do an example. Often in nutritional studies, people unconsciously over or under estimate how much food they ate. This can lead to inflated estimates as there may be more variability in the data than there actually is in real life. So let's keep only data with energy intakes between 2000 and 4000 kilocalories, in this case 20 and 40. Now we redo the analyses and compare the results. You'll notice the estimate for energy drops and the standard error increases. This is expected and shows us we were right that there many be some misreporting of energy intake. Notice also that the p value changes quite a bit, highlighting now unreliable it is.


---
## Time to practice!

```yaml
type: "FinalSlide"
key: "1931fc9890"
```

`@script`
Let's do some exercises!

