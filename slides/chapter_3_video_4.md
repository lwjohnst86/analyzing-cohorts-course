---
title: Tidying and extracting results from model objects
key: dfd73cee12b1663ba86738a4ec9a6c06

---
## Tidying and extracting results from model objects

```yaml
type: "TitleSlide"
key: "bf26b31ad8"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
We've now ran several models, checking the models and adjusting for variables. Now let's learn to tidy these model objects and extract the relevant results.


---
## Tidying up analysis objects

```yaml
type: "TwoColumns"
key: "a1381e11d6"
```

`@part1`
>  "Tidy \[models\] are all alike but every messy \[model\] is messy in its own way." – Hadley Wickham

- Use `tidy` from broom package {{1}}
    - Most statistics have "tidiers"


`@part2`
```{r}
# General tidying
tidy(model_object)

# Confidence interval
tidy(model_object, 
     conf.int = TRUE)

# Compute odds ratio 
# (only for some models)
tidy(model_object, 
     exponentiate = TRUE)
``` {{2}}


`@script`
Most statistical methods in R are developed by independent researchers, so there isn't often any underlying consistency in structure, making them a bit messy. This can be frustrating when learning a new technique. Thankfully there is the tidy function from the broom package to help you tidy up! Broom can tidy a large range of statistics. Tidy allows you to also calculate the confidence interval for measures of uncertainty and, for logistic regression, can convert the estimates into odds ratio.


---
## Base R way of "tidying" using `summary`

```yaml
type: "FullSlide"
key: "a62fb7015b"
```

`@part1`
```{r}
model <- glm(chd ~ weight + energy, 
             data = diet, family = binomial)
summary(model)
```

Part of the output: {{1}}

```
Call:
glm(formula = chd ~ weight + energy, family = binomial, data = diet)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-0.9022  -0.5882  -0.4908  -0.3905   2.3158  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)   
(Intercept)  1.795998   1.359699   1.321  0.18654   
weight      -0.007173   0.015157  -0.473  0.63604   
energy      -0.113894   0.041976  -2.713  0.00666 **
...
``` {{1}}


`@script`
We've already encountered the traditional way of trying to clean up the model results using summary. Here we have a logistic regression model with the diet dataset. Summary shows a lot of information that isn't easy to extract.


---
## Tidyverse way of tidying using `tidy`

```yaml
type: "FullSlide"
key: "587ee07b3a"
```

`@part1`
```{r}
library(broom)
tidy(model)
```

```
# A tibble: 3 x 5
  term        estimate std.error statistic p.value
  <chr>          <dbl>     <dbl>     <dbl>   <dbl>
1 (Intercept)  1.80       1.36       1.32  0.187  
2 weight      -0.00717    0.0152    -0.473 0.636  
3 energy      -0.114      0.0420    -2.71  0.00666
``` {{1}}


`@script`
The tidyverse way of cleaning up with the tidy function will take the model and convert it to a data frame, technically a tibble, so you can continue on wrangling with dplyr functions or to plot them. The information extracted is much easier to read and to use.


---
## Adding confidence intervals

```yaml
type: "FullSlide"
key: "ecbdb25867"
```

`@part1`
```{r}
tidy(model, conf.int = TRUE)
```

```
# A tibble: 3 x 7
  term    estimate std.error statistic p.value conf.low conf.high
  <chr>      <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
1 (Inter…  1.80       1.36       1.32  0.187    -0.868     4.48  
2 weight  -0.00717    0.0152    -0.473 0.636    -0.0375    0.0222
3 energy  -0.114      0.0420    -2.71  0.00666  -0.199    -0.0337
``` {{1}}


`@script`
In base R it requires extra work to extract the confidence intervals and combine them with the estimates. Confidence intervals are, very simply, a possible range of uncertainties in the value of the estimate. Here, tidy has the conf dot int argument, letting you add confidence intervals directly to the results tibble.


---
## Wrangling the results (if needed)

```yaml
type: "TwoColumns"
key: "a6edadb95f"
```

`@part1`
*Especially important for logistic regression-type analyses*

```{r}
model <- glm(
    chd ~ weight + fibre + energy,
    data = diet, family = binomial)
```

```{r}
tidied_model <- model %>%
    tidy(conf.int = TRUE) %>%
    select(term, estimate, 
           conf.low, conf.high) 
tidied_model 
``` {{1}}

```{r}
tidied_model %>% 
    mutate_at(vars(-term), exp)
``` {{3}}


`@part2`
```
# A tibble: 4 x 4
  term        estimate conf.low conf.high
  <chr>          <dbl>    <dbl>     <dbl>
1 (Intercept)  1.42     -1.31      4.17  
2 weight      -0.00321  -0.0356    0.0279
3 fibre       -0.737    -1.68      0.103 
4 energy      -0.0675   -0.164     0.0269
``` {{2}}

```
# A tibble: 4 x 4
  term        estimate conf.low conf.high
  <chr>          <dbl>    <dbl>     <dbl>
1 (Intercept)    4.12     0.270     64.7 
2 weight         0.997    0.965      1.03
3 fibre          0.479    0.186      1.11
4 energy         0.935    0.849      1.03
``` {{4}}


`@script`
Wrangling is easy now since the model is a tibble. For instance, if you run a logistic regression, you need to exponentiate the results to get odds ratios. We can pipe the model and select only the important variables. Check how the estimates look right now. It's hard to understand what the numbers mean. That's because we need to convert the estimates to odds ratios first.

To do that, we apply the exp function to exponentiate each variable except the term variable by using mutate at. Now the results look maybe a bit more familiar. We'll cover interpretation in the next chapter.


---
## Estimation and measures of uncertainty

```yaml
type: "FullSlide"
key: "8823985610"
```

`@part1`
> "Give ... estimates and ... their precision (eg, 95% confidence interval)" - STROBE guideline {{1}}

- Use estimation, uncertainty, distribution of effect size {{2}}
    - Science is about quantifying uncertainty
    - More insight, more utility for health decision making


`@script`
I mentioned keeping only important variables. Why were those variables important? Looking to STROBE, it says to provide the estimates with the 95 percent confidence interval. For science and health research, the estimate, also called the effect size, is much more useful when judging how import an exposure is on an outcome. Combined with the uncertainty, which gives a possible distribution to the effect size, you are able to gain more insight into your research question.


---
## The unreliable p-value

```yaml
type: "FullSlide"
key: "e177bf84fa"
```

`@part1`
- Avoid p-values {{1}}
    - Provides little to no clinical or scientific utility
    - Reliance could be harmful. 

Example: Drug treatment for disease has odds ratio of 0.8 (0.59, 1.01 95% CI), p>0.05 ("not significant"). Drug not used, even though uncertainty reaches an odds of 41% less disease from drug. {{2}}


`@script`
Why didn't I include the p value? The biggest reason is that it provides little to no clinical or public health value and it could actually be harmful! This is a lot detailed discussion on this, but let's take an example. Suppose a drug treatment for a disease has a zero point eight odds ratio, but has a p value above zero point zero five. Most studies would report this as not significant and not discuss it further. But at the lower bound of uncertainty the odds is forty one percent less disease in those taking the drug. So it could still be clinically useful!


---
## American Statistical Association statement on p-values

```yaml
type: "FullSlide"
key: "333093b1b3"
```

`@part1`
> "Scientific conclusions and business or policy decisions should not be based only on whether a p-value passes a specific threshold."  {{1}}

> "p-value does not provide a good measure of evidence regarding a model or hypothesis ... does not measure the size of an effect or the importance of a result" {{1}}

DOI to statement: https://doi.org/10.1080/00031305.2016.1154108 {{1}}


`@script`
What does a recognized, statistical organization say about p-values? Because of its misuse, the American Statistical Association, who are a large group of statisticians, made a statement to not rely on p values in scientific studies, as it is not good evidence for a hypothesis or for the study's findings importance. So, avoid using it.


---
## Let's get tidying!

```yaml
type: "FinalSlide"
key: "0410821a21"
```

`@script`
Alrighty, let's tidy up some models!

