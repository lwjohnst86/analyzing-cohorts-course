---
title: Tidying the data for later analysis
key: 4e1f8ff56b37d8caee655cf2b0b4639d

---
## Tidying the data for later analysis 

```yaml
type: "TitleSlide"
key: "edbfed5a7c"
```

`@lower_third`

name: Luke Johnston
title: Instructor

`@script`

---
## "Dichotomania": A major problem in health research

```yaml
type: "FullSlide"
key: "edbfed5a7c"
```

`@part1`

> Dichotomania: The obsession to convert continuous data into discrete or binary data, also known as dichotomizing. {{1}}

- Example: obesity defined as a body mass index of >30 while overweight is between 25-30 {{2}}
- Should be avoided at all costs {{3}}
- Dichotomizing or discretizing: {{4}}
    - Has no statistical utility
    - Has little to no clinical value
    - Misclassifies individuals
    - Reduces statistical power

`@script`

---
## The problem of discretizing: An visual example

```yaml
type: "TwoColumns"
```

`@part1`

| Category | BMI range |
|:---------|:----------|
| "Underweight" | < 18.5 |
| "Normal weight" | 18.5 - 25 |
| "Overweight" | 25 - 30 |
| "Obese" | > 30 | {{1}}

`@part2`

![Discretizing a continuous body mass index](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/6f6a793790e58b28f993ee4986409a5873fb424f/plot-discretising.png) {{2}}

`@script`

Maybe you are familiar with the different weight classes based on your body mass index, or BMI. These weight classes are often used in health research. This is a perfect example for why discretizing is a problem. Look at this figure here, which illustrates one of the reasons why discretizing should be avoided. You can see here that you have a BMI of 24.9 and be classified as normal weight, then gain a bit of weight and then be 25.1. You are now classified as overweight. You would now, statistically, be treated as someone who had a BMI of 29.9. Biologically this makes no sense. So when you have continuous data, don't dichotomize it.

---
## Reducing levels of an already discrete variable

```yaml
type: "FullSlide"
```

`@part1`

- Reasons to reduce: {{1}}
    - Small numbers in one or more category
    - Ease of later interpretation and generalization
    - Original categories were not clear

```{r}
# diet dataset from the Epi package
count(diet, job)

#> # A tibble: 3 x 2
#>   job             n
#>   <fct>       <int>
#> 1 Driver        102
#> 2 Conductor      84
#> 3 Bank worker   151
``` {{2}}

`@script`

While converting a continuous variable to a discrete one is almost always discouraged, for variables that are discrete it may make sense to reduce their levels. This could simplify the interpretation or maybe there are too many levels in the variable already. So reducing can be useful in this case. Let's look at job titles in this diet dataset. Using the count function on the variable, we can see there are three levels with more or less similar numbers between each level.

---
## Reducing levels of an already discrete variable

```yaml
type: "FullSlide"
```

`@part1`

```{r}
reduced_job <- diet %>%
    mutate(bank_worker = case_when(
        job == "Bank worker" ~ "Yes",
        job != "Bank worker" ~ "No",
        TRUE ~ NA_character_
    ))
``` {{1}}

```{r}
count(reduced_job, bank_worker)
#> # A tibble: 2 x 2
#>   bank_worker     n
#>   <chr>       <int>
#> 1 No            186
#> 2 Yes           151
``` {{2}}

`@script`

Since there are a large number of bank workers, we could, for later interpretation, reduce the categories to either a job as a bank worker or not. One way to do this is to use the case_when function, which is useful when you have more complicated categories.

---
## A short comment on outliers

```yaml
type: "FullSlide"
key: "edbfed5a7c"
```

`@part1`

> Short answer: Do *not* remove outliers unless the data itself is wrong. {{1}}

&nbsp;

> Longer answer: Outliers contain valuable scientific information. How they influence statistical results needs to be considered and analyzed. {{2}}

`@script`

Before finishing this lesson, I want to make a comment on dealing with outliers. Often times, you mean read that studies remove outliers. The short answer for what to do is... do not remove them... unless the data itself is actually wrong that may happen with data entry errors, outliers contains valuable scientific information. So you need to think about and include them in any analyses that you do.

---
## Lesson summary

```yaml
type: "FullSlide"
key: "1eba1be603"
```

`@part1`


`@script`


---
## Let's tidy up the cohort dataset more!

```yaml
type: "FinalSlide"
key: "1eba1be603"
```

`@script`


