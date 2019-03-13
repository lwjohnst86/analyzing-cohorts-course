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
    select(term, estimate, conf.low, conf.high)
tidied_model
```
{{1}}

```
# A tibble: 3 x 4
  term                      estimate    conf.low   conf.high
  <chr>                        <dbl>       <dbl>       <dbl>
1 (Intercept)             0.00000259  0.00000151  0.00000447
2 body_mass_index_scaled  1.27        0.930       1.73      
3 sd__(Intercept)        56.8        NA          NA         
``` 
{{2}}

`@script`
Wrangling after tidying is easy as the model is a tibble. So, if you run a logistic regression, you need to exponentiate the results to get odds ratios. Here we only select the important variables. Check how the estimates look right now. It's harder to understand what the numbers mean as they aren't as odds ratios.

To get them, we apply the exp function to exponentiate each variable, except the term variable, by using mutate at. Now the results maybe look a bit more familiar.


---
## Estimation and measures of uncertainty

```yaml
type: "FullSlide"
key: "8823985610"
```

`@part1`
> "Give ... estimates and ... their precision (eg, 95% confidence interval)" - STROBE guideline {{1}}

- Use estimation, uncertainty, distribution of effect size {{2}}
    - Science is quantifying uncertainty
    - More insight, more utility for health decision making


`@script`
I mentioned keeping only important variables. Why were those variables important? Looking to STROBE, it says to provide the estimates with the 95 percent confidence interval. For science and health research, the estimate, also called the effect size, is much more useful when judging how important an exposure is on an outcome. Combined with the uncertainty, which gives a possible distribution to the effect size, you are able to gain more insight into your research question.


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

