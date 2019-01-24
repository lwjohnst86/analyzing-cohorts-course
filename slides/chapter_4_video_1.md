---
title: Insert title here
key: 24be66708a350c97c6e8d86a7b2f7bf4

---
## Title Slide

```yaml
type: "TitleSlide"
key: "e6de14ec07"
```

`@lower_third`
name: Name Surname
title: Instructor


`@script`

- Give careful thought into how to best show results in a understandable and
impactful way for public health professionals and clinicians.
- Emphasize figures over tables, but know when to use either.
- Be cautious in interpreting "non-significant" findings, since they could also
have meaningful clinical implications.
- Use cautious language when presenting results
    - Especially with "causal" language
- Discuss STROBE guidelines in context of longitudinal study.

- Know how to understand and interpret the results (we'll get to knowing what
exactly is most useful to present and show for higher impact) Or move to chapter 4?

Lesson 1: Language and information to use when communicating the findings

- Danger of not showing all results or proper cautious interpretation, because
lives are at risk.
- Highlighting uncertainty and magnitude of results over "statistical significance"
- When to use stronger causal language
    - Depending on magnitude of finding, can use stronger causal language.
    - e.g. with smoking and lung cancer
    - Often argued that only Randomized Controlled Trials or animal/cell experiments 
    can use causal language, but that isn't always true.
    - Bradford Hill criteria (e.g. being smoking and lung cancer)
- Most of the time, your target audience for your results/analysis of cohort
studies is people in public health or government or clinicians... so you really
need to make sure that your results are *understandable* to *them*, not to other
data scientists or statisticians or epidemiologists (though you also need to 
target them).
- Discuss STROBE guidelines in context of longitudinal study.

Keep coming back to this throughout the chapter



---
## Insert title here...

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`



`@script`


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

`@script`

---
## Wrangling models into combined tibble

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

```{r}
map(unadjusted_models_list, ~ .x %>% mutate(model = "Unadjusted"))
```

```
```


`@script`


---
## Wrangling models into combined tibble

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`

```{r}
models_df <- bind_rows(
        map(unadjusted_models_list, ~ .x %>% mutate(model = "Unadjusted")),
        map(adjusted_models_list, ~ .x %>% mutate(model = "Adjusted"))
    ) %>%
    mutate(outcome = "chd")
models_df
```

```
# A tibble: 10 x 9
   term  estimate std.error statistic p.value conf.low conf.high model
   <chr>    <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl> <chr>
 1 (Int…    4.30     1.09      1.33   0.183      0.516    38.1   Unad…
 2 ener…    0.887    0.0404   -2.97   0.00297    0.817     0.958 Unad…
 3 (Int…    0.953    0.604    -0.0804 0.936      0.297     3.16  Unad…
 4 fibre    0.326    0.382    -2.94   0.00328    0.149     0.664 Unad…
 5 (Int…    6.03     1.36      1.32   0.187      0.420    88.5   Adju…
 6 ener…    0.892    0.0420   -2.71   0.00666    0.820     0.967 Adju…
 7 weig…    0.993    0.0152   -0.473  0.636      0.963     1.02  Adju…
 8 (Int…    1.24     1.09      0.199  0.842      0.145    10.5   Adju…
# … with 1 more variable: outcome <chr>
```


`@script`

---
## Insert title here...

```yaml
type: "FullSlide"
key: "c994d91d73"
```

`@part1`



`@script`



---
## Final Slide

```yaml
type: "FinalSlide"
key: "79b739124c"
```

`@script`


