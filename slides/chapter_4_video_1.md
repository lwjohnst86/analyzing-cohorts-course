---
title: Presenting cohort findings is tricky, be careful
key: 24be66708a350c97c6e8d86a7b2f7bf4

---
## Presenting cohort findings is tricky, be careful

```yaml
type: "TitleSlide"
key: "e6de14ec07"
```

`@lower_third`
name: Luke Johnston
title: Instructor


`@script`

Because of cohort studies focus on health and disease, how results are presented can directly impact people's lives and health. So care needs to be taken!

---
## Describe results cautiously, carefully

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

- **STROBE**: "Give a cautious overall interpretation of results"
- Emphasize tangible health impact
- Be clear and understandable
- Get feedback from healthcare practitioners
- "Non-significant" and "significant" are important {{1}}
- Show magnitude and uncertainy over "statistical significance" {{1}}


`@script`

In observational cohort studies, you should always have a healthy dose of caution when interpreting and presenting results. Because of the health and disease focus of cohorts, presenting results should emphasize more tangible health impact and try to be as clear and understandable as possible. The audience for your results will likely be public health professionals or clinicians, who aren't trained on interpreting complex model outputs. So be simple and concise. Find a healthcare practitioner who you can ask whether a certain graph or table is interpreted as you intend it to be.

The other thing to keep in mind is that both non-significant and significant findings are important from a health standpoint. So show all results. And in those results, emphasize magnitude of association and the uncertainty of that association.

---
## Causal reasoning in epidemiology

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

- Growing field in epidemiology
    - Book: [Causal Inference](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) 
    - Book: [Causal Inference in Statistics: A Primer](https://www.wiley.com/en-us/Causal+Inference+in+Statistics%3A+A+Primer-p-9781119186847)
- Use caution with causal language or interpretations
- When to use stronger causal language
    - Depends on magnitude and temporal response
    - e.g. with smoking and lung cancer

`@script`

One thing that often occurs is that observational findings are interpreted causally. While the field of causal reasoning in epidemiology is greatly expanding in recent years, it is still an area you should be cautious about. Unfortunately, humans often interpret associations as causal, so as the researcher you need to be extremely cautious when presenting findings from observational research. There are instances when causal language is easier to use, for example with the observation on smoking and lung cancer, but most of the time it is not so clear whether a causal relationship exists. Keep these things in mind whenever you present results from cohort studies.

---
## Wrangling models into combined tibble

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

```{r}
unadjusted_models_list
```
{{1}}

```
[[1]]
# A tibble: 2 x 7
  term        estimate std.error statistic p.value conf.low conf.high
  <chr>          <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
1 (Intercept)    4.30     1.09        1.33 0.183      0.516    38.1  
2 energy         0.887    0.0404     -2.97 0.00297    0.817     0.958

[[2]]
# A tibble: 2 x 7
  term        estimate std.error statistic p.value conf.low conf.high
  <chr>          <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
1 (Intercept)    0.953     0.604   -0.0804 0.936      0.297     3.16 
2 fibre          0.326     0.382   -2.94   0.00328    0.149     0.664
```
{{2}}

`@script`

Alright, let's get to the model results and coding. Here I ran two models for two predictors and tidied them up, as we learned in chapter three. I put these two models into a list to make it easier to work with. This is what the list of models looks like for the unadjusted models.

There is also the adjusted models list. Plotting or creating tables from the model results is most efficiently done with a single dataframe of the results. What we need to do is add model specific details to each model before trying to combine them all.

---
## Wrangling models into combined tibble

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

```{r}
library(purrr)
map(unadjusted_models_list, ~ .x %>% mutate(model = "Unadjusted"))
```

```
[[1]]
# A tibble: 2 x 8
  term        estimate std.error statistic p.value conf.low conf.high model     
  <chr>          <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl> <chr>     
1 (Intercept)    4.30     1.09        1.33 0.183      0.516    38.1   Unadjusted
2 energy         0.887    0.0404     -2.97 0.00297    0.817     0.958 Unadjusted

[[2]]
# A tibble: 2 x 8
  term        estimate std.error statistic p.value conf.low conf.high model     
  <chr>          <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl> <chr>     
1 (Intercept)    0.953     0.604   -0.0804 0.936      0.297     3.16  Unadjusted
2 fibre          0.326     0.382   -2.94   0.00328    0.149     0.664 Unadjusted
```
{{1}}


`@script`

A powerful way of doing that is by leveraging R's functional programming strengths. The purrr package has an amazing and consistent interface for doing functional programming. Using the map function, we can apply a function or chain of functions to a list or vector. The first argument takes the list or vector and the second argument takes the function to apply to each list item.

Here, I want to add a tag to each model indicating that the model is the unadjusted model. We can see how it adds to each model item in the list.

---
## Wrangling models into combined tibble

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

```{r}
map(unadjusted_models_list, ~ .x %>% mutate(model = "Unadjusted")) %>% 
    bind_rows()
```

```
# A tibble: 4 x 8
  term        estimate std.error statistic p.value conf.low conf.high model     
  <chr>          <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl> <chr>     
1 (Intercept)    4.30     1.09      1.33   0.183      0.516    38.1   Unadjusted
2 energy         0.887    0.0404   -2.97   0.00297    0.817     0.958 Unadjusted
3 (Intercept)    0.953    0.604    -0.0804 0.936      0.297     3.16  Unadjusted
4 fibre          0.326    0.382    -2.94   0.00328    0.149     0.664 Unadjusted
```
{{1}}


`@script`

Then, to convert that list into a single dataframe, we use dplyr's bind rows function, stacks the list dataframes into one.

---
## Wrangling models into combined tibble

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

```{r}
bind_rows(
    map(unadjusted_models_list, ~ .x %>% mutate(model = "Unadjusted")),
    map(adjusted_models_list, ~ .x %>% mutate(model = "Adjusted"))
    ) %>%
    mutate(outcome = "chd")
```

```
# A tibble: 10 x 9
   term     estimate std.error statistic p.value conf.low conf.high model  outcome
   <chr>       <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl> <chr>  <chr>  
 1 (Interc…    4.30     1.09      1.33   0.183      0.516    38.1   Unadj… chd    
 2 energy      0.887    0.0404   -2.97   0.00297    0.817     0.958 Unadj… chd    
 3 (Interc…    0.953    0.604    -0.0804 0.936      0.297     3.16  Unadj… chd    
 4 fibre       0.326    0.382    -2.94   0.00328    0.149     0.664 Unadj… chd    
 5 (Interc…    6.03     1.36      1.32   0.187      0.420    88.5   Adjus… chd    
 6 energy      0.892    0.0420   -2.71   0.00666    0.820     0.967 Adjus… chd    
 7 weight      0.993    0.0152   -0.473  0.636      0.963     1.02  Adjus… chd    
 8 (Interc…    1.24     1.09      0.199  0.842      0.145    10.5   Adjus… chd    
 9 fibre       0.346    0.412    -2.58   0.0100     0.149     0.746 Adjus… chd    
10 weight      0.995    0.0162   -0.319  0.750      0.963     1.03  Adjus… chd  
```
{{1}}

`@script`

Then we do the same thing for the adjusted models list, but instead we bind rows for both unadjusted and adjusted models. This puts all model items into a single dataframe. Lastly, we add information about the outcome. We now have a single model dataframe to plot and create tables from.

---
## Let's practice wrangling!

```yaml
type: "FinalSlide"
key: "79b739124c"
```

`@script`

Alright, let's get to wrangling the model results!
