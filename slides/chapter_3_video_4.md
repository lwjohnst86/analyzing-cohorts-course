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
title: Diabetes epidemiologist


`@script`
We've ran several models, checked them, and identified confounders. Now we'll tidy these models up, extract relevant results, and interpret them.


---
## Tidying up with broom.mixed

```yaml
type: "FullSlide"
key: "858da5ab02"
```

`@part1`
- Use `tidy` from broom package {{1}}
    - For mixed models use the broom.mixed package

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
Most statistical methods in R are developed by independent researchers, so there usually isn't an underlying consistency in presenting the method's results. They can be messy to deal with and can be a frustrating experience when learning a new technique. Thankfully there is the tidy function from the broom package to help out! Tidy allows you to clean up many analyses, calculate confidence intervals for uncertainty, and, for logistic regression, calculates the odds ratio. Odds ratios are covered more in the Logistic Regression course, but briefly, it is the odds of an outcome occurring given a predictor's presence compared to the odds given the predictor's absence.

You've used summary on the model before, which isn't a great interface to accessing the results. Calculating the confidence interval in base R requires extra work. To use tidy, you provide the model object, and set conf dot int to true, and you have a nice dataframe of results and confidence intervals. Confidence intervals are, very simply, a range of uncertainty of the estimate.


---
## Back-transforming with broom (if binary outcome)

```yaml
type: "FullSlide"
key: "e31b870008"
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
When you run analyses with a binary outcome, like disease status, you need to exponentiate the results to get the odds ratio. Exponentiating converts the original estimates of log-odds to odds ratios. With tidy, provide the argument exponentiate as true and you have the odds ratio now. Next, let's keep only the most important model results, effect, term, estimate, and the confidence interval.

Now we have a nice dataframe we can wrangle and plot from. So why are these variables important? We need the effect column for the fixed and random effects. And the magnitude and uncertainty around an association are vital as they give concrete results for your research. This is especially crucial for health research, as this information can dictate future health policies. Plus these are required from STROBE.


---
## Interpreting the model results

```yaml
type: "FullSlide"
key: "16e1b42876"
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
- Every unit increase in `term` is `estimate` odds increase in CVD, controlling  for other `term` {{2}}
- `estimate`, given data and assumptions, ranges from `conf.low` to `conf.high` {{3}}
- `estimate` for `ran_pars` effect indicates variation between subjects {{4}}


`@script`
Let's interpret these results. The estimates for the fixed effect rows are the values for the marginal or population level averages.

The estimate value itself is the estimated odds when the predictor or term increases by one unit, after controlling for the other predictors, in this case sex. So, because BMI is scaled, we say that a one standard deviation increase in BMI is associated with a one point twenty-six times higher risk for getting CVD.

We need to also consider the confidence interval. We interpret this by saying that for BMI, the estimated odds ranges from a zero point nine lower risk to a one point seventy-five higher risk.

Lastly, the estimate for the random effect indicates the variation between subjects. In this case, there is a lot, at fifty-six! We expect this, though, since individuals vary a lot.


---
## Unreliable p-value: American Statistical Association statement

```yaml
type: "FullSlide"
key: "333093b1b3"
```

`@part1`
> "... conclusions and ... decisions should not be based on [if] a p-value passes a threshold."  ...
> 
> "p-value [is] not ... a good measure of evidence ... [and] does not measure the size of an effect or the importance"

DOI to statement: https://doi.org/10.1080/00031305.2016.1154108 {{1}}

**Example**: Odds ratio of 0.8 (0.59, 1.01 95% CI), p>0.05 ("not significant"), uncertainty could reach 0.59 times lower odds of disease {{2}}


`@script`
You may have noticed that I didn't discuss the p-value. Why? Because it provides little to no clinical or public health utility. The American Statistical Association released a statement highlighting the problems with the p-value, stating they are not good evidence for a hypothesis or the importance of a finding.

For example, a drug lowers risk of a disease by zero point eight times, but the p-value is above zero point zero five. Normally studies would say this is not significant. But the uncertainty at the lower end is an odds of zero point fifty-nine times lower risk for disease, so it could be clinically useful!


---
## Let's get tidying!

```yaml
type: "FinalSlide"
key: "0410821a21"
```

`@script`
Alrighty, let's tidy up some models!

