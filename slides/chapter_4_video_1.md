---
title: Presenting cohort findings is tricky, be careful
key: 24be66708a350c97c6e8d86a7b2f7bf4

---
## Presenting cohort findings is tricky, be careful

```yaml
type: "TitleSlide"
key: "575864dc6e"
```

`@lower_third`

name: Luke Johnston
title: Postdoctoral researcher in diabetes epidemiology


`@script`
Since cohort studies focus on health and disease, the way results are presented can directly impact people's lives and health, so care needs to be taken!


---
## Describe results cautiously, carefully

```yaml
type: "FullSlide"
key: "42434a7ac4"
```

`@part1`
- **STROBE**: "Give a cautious overall interpretation of results"
- Emphasize tangible health impact
- Be clear and understandable
- Get feedback from healthcare practitioners
- "Non-significant" and "significant" are important {{1}}
- Show magnitude and uncertainy over "statistical significance" {{1}}


`@script`
In observational cohort studies, you need to use a healthy dose of caution when interpreting and presenting results. This is also stated within the STROBE guidelines. If you recall, STROBE was developed to make studies such as cohorts more rigorous, standardized, and transparent.

Emphasize more tangible health impacts when presenting results and try to be as clear and understandable as possible. Your audience or readers will likely be public health professionals or clinicians who aren't trained in interpreting complex models, so be simple and concise. 

Keep in mind that both non-significant and significant findings are important from a health standpoint. Show all results, emphasizing the magnitude of association and the uncertainty of that association.


---
## Causal reasoning in epidemiology

```yaml
type: "FullSlide"
key: "452c839802"
```

`@part1`
- Growing field in epidemiology
- Use caution with causal language or interpretations {{1}}
- Using stronger causal language depends on magnitude and temporal response {{2}}
    - E.g. with smoking and lung cancer


`@script`
Oftentimes, observational findings are interpreted causally. While the field of causal reasoning in epidemiology has expanded recently, it is still an area to exercise cautious. 

Unfortunately, humans often interpret associations as causal, so as the researcher you need to be extremely cautious when presenting findings from observational research. 

There are times when causal language is justified, for example with the observation of cigarette smoking and lung cancer. But usually it isn't clear whether a causal relationship exists. Keep these in mind when you present cohort study results.


---
## Multiple models as lists, tidying with map

```yaml
type: "FullSlide"
key: "633c32f759"
```

`@part1`
```{r}
unadjusted_models_list <- list(
    glmer(chd ~ energy, family = binomial, data = diet),
    glmer(chd ~ fibre, family = binomial, data = diet)
)
```
{{1}}

```{r}
library(purrr)
tidied_unadjusted_models_list <- unadjusted_models_list %>%
    map(~ tidy(.x, conf.int = TRUE, exponentiate = TRUE) %>%
			select(effect, terms, estimate, conf.low, conf.high))
```
{{2}}


`@script`
Given you'll likely be working with multiple models, my suggestion is put your models into a single list, since working with lists is very easy in R thanks to the purrr package. 

Here, I've ran two models using what we learned from the previous chapter and stored them as a list into the object unadjusted models list. I did the same thing for the adjusted models by storing them as a list.

Then, to apply the tidy function to each of those models, we use the map function. Map takes two arguments. The list object and the function. We set the function with the tilde symbol and refer to the object by dot x.


---
## Contents are multiple models stored in sequence

```yaml
type: "FullSlide"
key: "a7a664a9c8"
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
You see that the content is a list of model results, where two models are inside the object. These results are for the unadjusted models. The adjusted models list looks the same, except there are additional predictors.

Plotting or creating tables from the results is more efficient using a single dataframe, but we need to add some model specific details before combining them.


---
## Use map to add more model details

```yaml
type: "FullSlide"
key: "ed2ccee5b2"
disable_transition: true
```

`@part1`
```{r}
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
Using the map function from the purrr package leverages R's powerful functional programming strengths. purrr has a wonderful and consistent interface for using this functional programming. 

Let's use map to add more information to the model objects in the list. We'll add a tag to each model item in the list to indicate that the models are unadjusted.

When we look at the list of models, we see that column has been added to all of them.


---
## Use bind_rows to convert list into data frame

```yaml
type: "FullSlide"
key: "25c5902e31"
disable_transition: true
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
Then, we can convert the list of models into a single dataframe of the results. We do this using dplyr's bind underline rows function to stack the list dataframes into one.


---
## Bind multiple lists and continue piping

```yaml
type: "FullSlide"
key: "6d9abd6a9d"
disable_transition: true
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
Let's do the same thing wit the list of adjusted models, but instead, we bind rows for both unadjusted and adjusted models. This puts all model items into a single dataframe. Lastly, let's add information about the outcome. We now have a single model dataframe that we can use to create plots and tables.


---
## Let's practice wrangling!

```yaml
type: "FinalSlide"
key: "07d2f95588"
```

`@script`
Alright, let's get to wrangling the model results!

