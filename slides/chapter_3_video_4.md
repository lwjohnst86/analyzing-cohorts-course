---
title: "Tidying and extracting results from model objects"
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

We've now ran several models, adjusting and not adjusting for variables, did interaction and sensitivity analyses. Now is the time to learn how to take those model objects, tidy them up, and extract the necessary results from them.

---
## Tidying up analysis objects

```yaml
type: "TwoColumns"
```

`@part1`

>  "Tidy \[models\] are all alike but every messy \[model\] is messy in its own way." – Hadley Wickham

- Use `tidy` function from broom package {{1}}
    - Should have "tidiers" for most statistics

`@part2`
    
```{r}
# General tidying
tidy(model_object)
# Confidence interval
tidy(model_object, conf.int = TRUE)
# Backtransform a log for odds ratio 
# (for some models)
tidy(model_object, exponentiate = TRUE)
``` {{2}}

`@script`

Because most statistical methods in R are developed by independent researchers, they usually don't have any underlying consistency. They are developed in a messy way. This can be really frustrating when you want to learn a new technique. Thankfully there is the broom package with the tidy function to help you make the models tidy. Broom has tidying functions for a large range of statistical techniques. The tidy function allows you to also calculate the confidence interval for measures of uncertainty and also allows conversion of the estimates into odds ratio, but only for simpler logistic regression models.

---
## Base R way of "tidying" using `summary`

```yaml
type: "FullSlide"
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

Let's show an example. Here we are creating a logistic regression model from the diet dataset. A commonly used interface for models is to use the summary function. This is a great way to get a summary of the model, since it shows a lot of useful information. Here, not all of that information is show. But it can be difficult if you want to extract any results for this model object.

---
## Tidyverse way of tidying using `tidy`

```yaml
type: "FullSlide"
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

Let's see the tidyverse way of doing things. Here we use the tidy function from the broom package. Just like the summary function, the tidy function knows what type of analysis you did and extracts the appropriate information. The result is a data frame, technically a tibble, that lets you easily wrangle and plot these results. You see here that the column names are nicely tidy, and all the important information is here. 

---
## `tidy`ing and adding confidence intervals

```yaml
type: "FullSlide"
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
Often in base R it requires extra work to extract the confidence intervals and merge them into the estimates. Confidence intervals are, very simply, a possible range of uncertainties in the value of the estimate. Back to the code, here, the tidy function has the conf dot int argument, which lets you add the confidence intervals to the side. Now we have the model results in an easy to use format.

---
## Wrangling the results (if needed)

```yaml
type: "TwoColumns"
```

`@part1`

*Especially important for logistic regression-type analyses*

```{r}
model <- glm(chd ~ weight + fibre + energy,
             data = diet, family = binomial)


tidied_model <- tidy(model, conf.int = TRUE) %>%
    select(term, estimate, conf.low, conf.high) {{1}}
tidied_model {{1}}

tidied_model %>% {{3}}
    mutate_at(vars(-term), exp) {{3}}

```

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

Now, because the tidy model is a tibble, you can use dplyr functions to do easy wrangling on the results if necessary. So for instance, if you run a logistic regression, you will need to exponentiate the results to get odds ratios for the estimates and confidence intervals. Here, we pipe the tidy model and select only the important variables. We'll cover why these are more important in the next two slides. Before doing anything else, let's take a look at the model results. We haven't covered interpretation much, but in this case, it's hard to understand what the numbers mean here. That's because the model was a logistic model. So we need to convert the estimates to odds ratios.

To do that, we apply the exp function to exponentiate each variable except the term variable by using the mutate at function. Now, when we look at the results, we see that they are maybe a bit more familiar. We can interpret these as odds ratios now.

---
## Estimation, measures of uncertainty, and the unreliable p-value

```yaml
type: "FullSlide"
```

`@part1`

> "Give ... estimates and ... their precision (eg, 95% confidence interval)" - STROBE guideline {{1}}

- Use estimation, uncertainty, distribution of effect size {{2}}
    - Science is about quantifying uncertainy
    - More insight, more utility for health decision making

- Avoid p-values {{3}}
    - Provides little to no clinical or scientific utility
    - Reliance could be harmful. 

Example: Drug treatment for disease has odds ratio of 0.8 (0.59, 1.01 95% CI), p>0.05 ("not significant"). Drug not used, even though uncertainty reaches an odds of 41% less disease from drug. {{4}}

`@script`

As I mentioned, we'll cover why some results are more important then others. So what's important from the model? If you read the title of this slide, you'd see that estimation and not p-values are what's important. Looking to STROBE, it says to provide the estimates with the ninety five percent confidence interval of the models. For science and health research, the estimate, also called the effect size, is much more useful for judging importance of an exposure on an outcome. Combined with the uncertainty, which gives a possible distribution to the effect size, you are able to gain more insight into your research question.

Let's move over to the p-value. As much as possible, avoid using or relying on the p-value. The biggest reason why is because it provides little to no clinical or public health use and it could in fact be harmful! For example, suppose a drug treatment for a disease has a zero point eight odds ratio, but has a p-value above zero point zero five. Most studies would still report this as not significant and not discuss it further, but at the lower bound of uncertainty the drug has an odds of forty one percent less disease. So it could still be clinically useful!

---
## American Statistical Association statement on p-values

```yaml
type: "FullSlide"
```

`@part1`


> "Scientific conclusions and business or policy decisions should not be based only on whether a p-value passes a specific threshold."  {{1}}
> "p-value does not provide a good measure of evidence regarding a model or hypothesis ... does not measure the size of an effect or the importance of a result" {{1}}

DOI to statement: https://doi.org/10.1080/00031305.2016.1154108 {{1}}

`@script`

But what does a recognized, statistical organization say about this? The American Statistical Association, which represents a large group of statisticians, made a statement specifically calling on researchers to not rely on p values in scientific studies, as it does not provide a good measure of evidence for a hypothesis or for importance of the study's findings. So, avoid using the p value.

---
## Let's get tidying!

```yaml
type: "FinalSlide"
key: "0410821a21"
```

`@script`

Alrighty, let's tidy up some models!
