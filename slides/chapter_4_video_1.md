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
    glmer(got_cvd ~ total_cholesterol_scaled + (1 | subject_id), 
        family = binomial, data = tidied_framingham),
    glmer(got_cvd ~ body_mass_index_scaled + (1 | subject_id), 
        family = binomial, data = tidied_framingham)
)
```
{{1}}

```{r}
library(purrr)
tidied_unadjusted_models_list <- unadjusted_models_list %>%
    map(~tidy(.x, conf.int = TRUE, exponentiate = TRUE) %>%
            select(effect, term, estimate, conf.low, conf.high))
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
# A tibble: 3 x 5
  effect   term                        estimate     conf.low  conf.high
  <chr>    <chr>                          <dbl>        <dbl>      <dbl>
1 fixed    (Intercept)               0.00000273  0.000000334  0.0000223
2 fixed    total_cholesterol_scaled  1.10        0.319        3.78     
3 ran_pars sd__(Intercept)          56.5        NA           NA        

[[2]]
# A tibble: 3 x 5
  effect   term                      estimate     conf.low  conf.high
  <chr>    <chr>                        <dbl>        <dbl>      <dbl>
1 fixed    (Intercept)             0.00000248  0.000000289  0.0000213
2 fixed    body_mass_index_scaled  1.62        0.410        6.38     
3 ran_pars sd__(Intercept)        56.8        NA           NA        
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
map(unadjusted_models_list, ~mutate(.x, model = "Unadjusted"))
```

```
[[1]]
# A tibble: 3 x 6
  effect   term                       estimate     conf.low conf.high model    
  <chr>    <chr>                         <dbl>        <dbl>     <dbl> <chr>    
1 fixed    (Intercept)              0.00000273  0.000000334   2.23e-5 Unadjust…
2 fixed    total_cholesterol_scal…  1.10        0.319         3.78e+0 Unadjust…
3 ran_pars sd__(Intercept)         56.5        NA            NA       Unadjust…

[[2]]
# A tibble: 3 x 6
  effect   term                      estimate     conf.low  conf.high model    
  <chr>    <chr>                        <dbl>        <dbl>      <dbl> <chr>    
1 fixed    (Intercept)             0.00000248  0.000000289  0.0000213 Unadjust…
2 fixed    body_mass_index_scaled  1.62        0.410        6.38      Unadjust…
3 ran_pars sd__(Intercept)        56.8        NA           NA         Unadjust…
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
map(unadjusted_models_list, ~mutate(.x, model = "Unadjusted")) %>% 
    bind_rows()
```

```
# A tibble: 6 x 6
  effect   term                  estimate   conf.low conf.high model   
  <chr>    <chr>                    <dbl>      <dbl>     <dbl> <chr>   
1 fixed    (Intercept)         0.00000273    3.34e-7   2.23e-5 Unadjus…
2 fixed    total_cholesterol…  1.10          3.19e-1   3.78e+0 Unadjus…
3 ran_pars sd__(Intercept)    56.5          NA        NA       Unadjus…
4 fixed    (Intercept)         0.00000248    2.89e-7   2.13e-5 Unadjus…
5 fixed    body_mass_index_s…  1.62          4.10e-1   6.38e+0 Unadjus…
6 ran_pars sd__(Intercept)    56.8          NA        NA       Unadjus…
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
bind_rows(map(unadjusted_models_list, ~ mutate(.x, model = "Unadjusted")),
          map(adjusted_models_list, ~ mutate(.x, model = "Adjusted"))) %>%
    mutate(outcome = "got_cvd")
```

```
# A tibble: 14 x 7
   effect   term                       estimate     conf.low conf.high model     outcome
   <chr>    <chr>                         <dbl>        <dbl>     <dbl> <chr>     <chr>  
 1 fixed    (Intercept)              0.00000273  0.000000334   2.23e-5 Unadjust… got_cvd
 2 fixed    total_cholesterol_scal…  1.10        0.319         3.78e+0 Unadjust… got_cvd
 3 ran_pars sd__(Intercept)         56.5        NA            NA       Unadjust… got_cvd
 4 fixed    (Intercept)              0.00000248  0.000000289   2.13e-5 Unadjust… got_cvd
 5 fixed    body_mass_index_scaled   1.62        0.410         6.38e+0 Unadjust… got_cvd
 6 ran_pars sd__(Intercept)         56.8        NA            NA       Unadjust… got_cvd
 7 fixed    (Intercept)              0.00000532  0.000000503   5.61e-5 Adjusted  got_cvd
 8 fixed    total_cholesterol_scal…  1.21        0.347         4.22e+0 Adjusted  got_cvd
 9 fixed    sexWoman                 0.272       0.0143        5.15e+0 Adjusted  got_cvd
10 ran_pars sd__(Intercept)         55.5        NA            NA       Adjusted  got_cvd
```
{{1}}


`@script`
Let's do the same thing with the list of adjusted models, but instead, we bind rows for both unadjusted and adjusted models. This puts all model items into a single dataframe. Lastly, let's add information about the outcome. We now have a single model dataframe that we can use to create plots and tables.


---
## Let's practice wrangling!

```yaml
type: "FinalSlide"
key: "07d2f95588"
```

`@script`
Now you know how to wrangling model results. Let's practice!

