---
title: Tidying and interpreting model results
key: dfd73cee12b1663ba86738a4ec9a6c06

---
## Tidying and interpreting model results

```yaml
type: "TitleSlide"
key: "bf26b31ad8"
```

`@lower_third`

name: Luke Johnston
title: Postdoctoral researcher in diabetes epidemiology


`@script`
We've now ran several models, checked them, and adjusted for variables. Now let's tidy these model objects up, extract the relevant results, and interpret what they mean.

---
## Tidying up with broom.mixed

```yaml
type: "FullSlide"
```

`@part1`
- Use `tidy` from broom package {{1}}
    - For mixed models use the broom.mixed package
    - "Tidiers" for most statistics

```{r}
library(broom.mixed)
model <- glmer(got_cvd ~ body_mass_index_scaled + sex + (1 | subject_id),
      data = tidied_framingham, family = binomial)
      
# General tidying
tidy(model_object)

# Confidence interval
tidy(model_object, conf.int = TRUE)
```
{{2}}

```
# A tibble: 4 x 9
  effect  group   term         estimate std.error statistic p.value conf.low conf.high
  <chr>   <chr>   <chr>           <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
1 fixed   NA      (Intercept)   -12.4       0.321    -38.5   0       -13.0     -11.7  
2 fixed   NA      body_mass_i…    0.229     0.169      1.35  0.177    -0.103     0.560
3 fixed   NA      sexWoman       -0.916     0.365     -2.51  0.0122   -1.63     -0.200
4 ran_pa… subjec… sd__(Interc…   56.1      NA         NA    NA        NA        NA    
```
{{3}}


`@script`
Most statistical methods in R are developed by independent researchers, so there isn't often an underlying consistency between methods, so they can be messy and can be a frustrating experience when learning a new technique. Thankfully there is the tidy function from the broom package to help out! Tidy allows you to tidy up many types of analyses and also can calculate the confidence interval for measures of uncertainty and, for logistic regression, can give the odds ratio. Odds ratios are covered in more detail in the Logistic Regression course, but briefly, it is the odds of an outcome occurring given a predictor's presence compared to the odds of the outcome occurring given the predictor's absence.

You've been exposed using summary to get information from the model.

Why do we need to exponentiate? because the model uses a binomial distribution, the estimates are computed on the log-odds scale. So in order to back-transform them, we need to exponentiate so the estimates are on the odds scale and can be interpreted as a odds ratio.

In base R, extracting the confidence interval requires extra work to extract and to combine them with the estimates. Confidence intervals are, very simply, a possible range of uncertainties in the value of the estimate. Here, tidy has the conf dot int argument, letting you add confidence intervals directly to the results.


---
## Back-transforming with broom (if binary outcome)

```yaml
type: "FullSlide"
```

`@part1`

```{r}
tidied_model <- model %>%
    tidy(exponentiate = TRUE, conf.int = TRUE) %>%
    select(effect, term, estimate, conf.low, conf.high)
tidied_model
```
{{1}}

```
# A tibble: 4 x 5
  effect   term                      estimate    conf.low   conf.high
  <chr>    <chr>                        <dbl>       <dbl>       <dbl>
1 fixed    (Intercept)             0.00000430  0.00000230  0.00000807
2 fixed    body_mass_index_scaled  1.26        0.902       1.75      
3 fixed    sexWoman                0.400       0.196       0.819     
4 ran_pars sd__(Intercept)        56.1        NA          NA         
``` 
{{2}}

- Emphasize estimation and uncertainty (as per STROBE) {{3}}
- Gives more insight and utility for health decision making {{3}}

`@script`
Wrangling after tidying is easy as the model is a tibble. So, if you run a logistic regression, you need to exponentiate the results to get odds ratios. Here we only select the important variables. Check how the estimates look right now. It's harder to understand what the numbers mean as they aren't as odds ratios.

To get them, we apply the exp function to exponentiate each variable, except the term variable, by using mutate at. Now the results maybe look a bit more familiar.

I mentioned keeping only important variables. Why were those variables important? Looking to STROBE, it says to provide the estimates with the 95 percent confidence interval. For science and health research, the estimate, also called the effect size, is much more useful when judging how important an exposure is on an outcome. Combined with the uncertainty, which gives a possible distribution to the effect size, you are able to gain more insight into your research question.

---
## Interpreting the model results

```yaml
type: "FullSlide"
```

`@part1`

```
# A tibble: 4 x 5
  effect   term                      estimate    conf.low   conf.high
  <chr>    <chr>                        <dbl>       <dbl>       <dbl>
1 fixed    (Intercept)             0.00000430  0.00000230  0.00000807
2 fixed    body_mass_index_scaled  1.26        0.902       1.75      
3 fixed    sexWoman                0.400       0.196       0.819     
4 ran_pars sd__(Intercept)        56.1        NA          NA         
``` 

- `estimate` for `fixed` effect is the "marginal" (population-level) effect {{1}} 
- Every unit increase in `term` is `estimate` odds increase in CVD, controlling 
for other `term` {{2}}
- `estimate`, given data and assumptions, ranges from `conf.low` to `conf.high` {{3}}
- `estimate` for `ran_pars` effect indicates variation between subjects {{4}}

`@script`

Let's interpret these results. Here, the fixed effect estimate is the value for the marginal or population level average.

The estimate value itself is the estimated odds when the predictor or term increases by one unit, after controlling for the other predictors, in this case sex. So in this case, because BMI is scaled, we say that a one standard deviation increase in BMI is associated with a one point twenty-six times higher risk for getting CVD.

We need to also consider the confidence interval. We interpret this by saying that for BMI, the estimated odds ranges from a zero point nine lower risk to a one point seventy-five higher risk.

Lastly, the estimate for the random effect term indicates the amount of variation between subjects. In this case, there is a lot of variation! Which is actually expected at the individual level.


---
## The unreliable p-value: A statement from the American Statistical Association

```yaml
type: "FullSlide"
key: "333093b1b3"
```

`@part1`
> "Scientific conclusions and business or policy decisions should not be based on whether a p-value passes a threshold."  ...
> "p-value does not provide a good measure of evidence regarding a model or hypothesis ... does not measure the size of an effect or the importance of a result"

DOI to statement: https://doi.org/10.1080/00031305.2016.1154108 {{1}}

**Example**: Odds ratio of 0.8 (0.59, 1.01 95% CI), p>0.05 ("not significant") for drug treatment, uncertainty could reach 0.59 times lower odds of disease from drug {{2}}


`@script`
You may have noticed that I didn't include or discuss the p-value. Why? Mostly because it provides little to no clinical or public health utility. The American Statistical Association released a statement highlighting the problem with using and relying on the p-value, as they are not good evidence for a hypothesis or for the importance of a study's findings.

Let's take an example. Suppose a drug treatment for a disease has an odds ratio of zero point eight, but has a p value above zero point zero five. Most studies would report this as not significant and not discuss it further. But at the lower bound of uncertainty the odds is forty one percent less disease in those taking the drug. So it could still be clinically useful!


---
## Let's get tidying!

```yaml
type: "FinalSlide"
key: "0410821a21"
```

`@script`
Alrighty, let's tidy up some models!

