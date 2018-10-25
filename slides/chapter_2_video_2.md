---
title: Insert title here
key: 4e1f8ff56b37d8caee655cf2b0b4639d

---
## Tidy cohort data and wrangling into analyzable form.

```yaml
type: "TitleSlide"
key: "edbfed5a7c"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`

- DON't Dichotomize!!
    - unless data values look like it could or if a confounder in model.. (e.g. cigarettes)
    - show visual of why dich is wrong (point with colours of categories)
- Categorical variable modication:
    - sometimes some categories are too small, so sometimes for model
    interpretation and generalizability, grouping categories makes sense,
    and to also balance the sample between groups.


- Dealing with outliers (or not)

---
## "Dichotomania": A major problem in health research

```yaml
type: "FullSlide"
key: "edbfed5a7c"
```

`@part1`


> Dichotomania: The obsession to convert continuous data into discrete or binary data, also known as dichotomizing. For instance, obesity is defined as a body mass index of >30 while overweight is defined as between 25-30... {{1}}

- Should be avoided at all costs {{2}}
- Dichotomizing or discretizing: {{3}}
    - Has no statistical utility
    - Has little to no clinical value
    - Misclassifies individuals
    - Reduces statistical power

`@script`

---
## The problem of discretizing: An visual example

```yaml
type: "TwoColumns"
key: "edbfed5a7c"
```

`@part1`

| Category | BMI range |
|:---------|:----------|
| "Underweight" | < 18.5 |
| "Normal weight" | 18.5 - 25 |
| "Overweight" | 25 - 30 |
| "Obese" | > 30 | {{1}}

`@part2`

![Discretizing a continuous body mass index]() {{2}}

`@script`

Maybe you are familiar with the different weight classes based on your body mass index, or BMI. These weight classes are often used in health research. This is a perfect example for why discretizing is a problem. Look at this figure here, which illustrates one of the reasons why discretizing should be avoided. You can see here that 

---
## Reducing levels of an already discrete variable

```yaml
type: "FullSlide"
```

`@part1`

```{r}
# diet dataset from the Epi package
count(diet, job)

#> # A tibble: 3 x 2
#>   job             n
#>   <fct>       <int>
#> 1 Driver        102
#> 2 Conductor      84
#> 3 Bank worker   151
``` {{1}}

```{r}
reduced_job <- diet %>%
    mutate(bank_worker = case_when(
        job == "Bank worker" ~ "Yes",
        job != "Bank worker" ~ "No",
        TRUE ~ NA_character_
    ))
``` {{2}}

```{r}
count(reduced_job, bank_worker)
#> # A tibble: 2 x 2
#>   bank_worker     n
#>   <chr>       <int>
#> 1 No            186
#> 2 Yes           151
``` {{3}}

`@script`

While converting a continuous variable to a discrete one is almost always discouraged, for variables that are discrete it may make sense to reduce their levels. This could simplify the interpretation or maybe there are too many levels in the variable already. So reducing can be useful in this case. Let's look at job titles in this diet dataset. Using the count function on the variable, we can see there are three levels with more or less similar numbers between each level. For showing the 

---
## 

```yaml
type: "FullSlide"
key: "edbfed5a7c"
```

`@part1`

`@script`

---
## Final Slide

```yaml
type: "FinalSlide"
key: "1eba1be603"
```

`@script`


