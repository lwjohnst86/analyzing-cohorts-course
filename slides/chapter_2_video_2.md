---
title: Tidying discrete data for later analysis
key: 4e1f8ff56b37d8caee655cf2b0b4639d

---
## Tidying discrete data for later analysis 

```yaml
type: "TitleSlide"
key: "edbfed5a7c"
```

`@lower_third`

name: Luke Johnston
title: Instructor

`@script`

Cohort datasets often contain many discrete variables, such as from questionnaires. Usually, this data isn't tidy or as usable in later analyses. In this lesson we will go over how and when to tidy up discrete data.

---
## A comment on "dichotomania"

```yaml
type: "FullSlide"
```

`@part1`

> Dichotomania: The obsession to convert continuous data into discrete or binary data, also known as discretizing or dichotomizing. {{1}}

- Example: obesity = body mass index >30, overweight = between 25-30 {{2}}

`@script`
But before continuing, I want to talk about a problem common in health research... and that is something known as dichotomania. Dichotomania is an obsession for researchers to convert continuous data into discrete or binary data. These processes are known as discretizing or dichotomising. An example of this is with the definition of obesity, which is any BMI >30.

---
## A comment on "dichotomania"

```yaml
type: "FullSlide"
```

`@part1`

- Should be avoided {{1}}
- Dichotomizing or discretizing: {{2}}
    - No statistical utility
    - Little to no clinical value
    - High misclassification
    - Reduces power

`@script`

This is be avoided at all costs because there are many problems with this. Discretizing has no statistical utility, doesn't provide much clinical value, misclassification of individual's health risk is high, and you reduce statistical power.

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

Let's show an example. Maybe you are familiar with the different weight classes based on your body mass index, or BMI. These weight classes are often used in health research and perfectly shows why discretizing is a problem. For instance, someone with a BMI of 24.9 would be classified as normal weight. But, gain a bit of weight or eat a large meal and that BMI could become 25.1 and now that person is classified as overweight. You would now, statistically, be treated equally as someone who has a BMI of 29.9. Biologically this makes no sense. So when you have continuous data, don't dichotomize it.

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

While converting a continuous variable to a discrete one is almost always discouraged, for already discrete variables it may make sense to reduce their levels. This could simplify the interpretation or maybe there are too many levels in the variable already. So reducing can be useful in this case. Let's look at job titles in this diet dataset. Using the count function on the variable, we can see there are three levels with more or less similar numbers between each level.

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

Since there are a large number of bank workers, we could, for later interpretation, reduce the categories to either a job as a bank worker or not. One way to do this is to use the case_when function, which is useful when you have more complicated categories. The case_when function takes a condition on the left side of the tilde and the value on the right side. Each condition follows the comma. The final condition for missing values should be formatted as shown here for character data. Now, when we use count to check that the new variable has been successfully changed.

---
## A short comment on outliers

```yaml
type: "FullSlide"
```

`@part1`

> Short answer: Do *not* remove outliers unless the data itself is wrong. {{1}}

&nbsp;

> Longer answer: Outliers contain valuable scientific information. How they influence statistical results needs to be considered and analyzed. {{2}}

`@script`

Before finishing this lesson, I want to make a comment on dealing with outliers. Often times, you may read some studies that remove outliers from their data. Simply, don't do this... unless the data itself is actually wrong, like for data entry errors. Outliers on their own contain valuable scientific information. So you need to think about and include them in any analyses that you do.

---
## Lesson summary

```yaml
type: "FullSlide"
key: "1eba1be603"
```

`@part1`

- Don't discretise. Keep continuous data continuous.
- Use `count` to check categorical data and `case_when` to reduce levels.
- Don't remove outliers (unless they are wrong).

`@script`

In summary, keep continuous data continuous. Use count and case_when functions to check and reduce categorical data. And lastly, keep outliers in your data.

---
## Let's tidy up the cohort dataset more!

```yaml
type: "FinalSlide"
key: "1eba1be603"
```

`@script`

Alright, let's do some tidying!
