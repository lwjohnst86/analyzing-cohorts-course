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
Cohort datasets often contain many discrete variables. Questionnaires are an example of this. In this lesson, we will discuss when and how to tidy up discrete data.


---
## A comment on "dichotomania"

```yaml
type: "FullSlide"
key: "f3f4f626e0"
```

`@part1`
> Dichotomania: The obsession to convert continuous data into discrete or binary data, also known as discretizing or dichotomizing. {{1}}

- Example: {{2}}
  - obese = body mass index > 30 {{2}}
  - overweight = body mass index between 25-30 {{2}}


`@script`
Before continuing, I want to talk about a problem common in health research, which is known as dichotomania. Dichotomania is an obsession researchers have with converting continuous data into discrete or binary data. These processes are known as discretizing or dichotomizing. An example of this is the definition of obesity, which is any BMI greater than 30.


---
## A comment on "dichotomania"

```yaml
type: "FullSlide"
key: "e382f259fd"
```

`@part1`
- Should be avoided {{1}}
- Dichotomizing or discretizing: {{2}}
    - No statistical utility
    - Little to no clinical value
    - High misclassification
    - Reduces power


`@script`
Discretizing should be avoided at all costs because of the problems it can cause. It has no statistical utility, doesn't provide much clinical value, and reduces statistical power. Using this method, the misclassification of an individual's health risk is high.


---
## The problem of discretizing: An visual example

```yaml
type: "TwoColumns"
key: "9d1583baf0"
```

`@part1`
| Category | BMI range |
|:---------|:----------|
| "Underweight" | < 18.5 |
| "Normal weight" | 18.5 - 25 |
| "Overweight" | 25 - 30 |
| "Obese" | > 30 | {{1}}


`@part2`
```{r}
diet %>%
    mutate(BMI = weight / ((height / 100) ^ 2)) %>%
    ggplot(aes(x = BMI)) +
    geom_histogram(color = "black", fill = "lightyellow", 
                   bins = 40) +
    geom_vline(xintercept = c(20, 25, 30), 
               size = 1, linetype = "dashed") +
    xlab("Body mass index")
``` {{1}}


`@script`
For example, you may be familiar with the different weight classes based on your body mass index, or BMI. These weight classes, shown in the table, are often used in health research and show why discretizing is a problem. Let's plot BMI from the diet cohort. This code will create the image shown next.


---
## The problem of discretizing: An visual example

```yaml
type: "FullSlide"
key: "3b16cf3f48"
```

`@part1`
![Discretizing a continuous body mass index](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/6f6a793790e58b28f993ee4986409a5873fb424f/plot-discretising.png) {{2}}


`@script`
Here we see how continuous BMI smoothly passes through each discrete category. Someone with a BMI of 24 point 9 would be classified as normal weight. If they gain a bit of weight and their BMI becomes 25 point 1, they would be classified as overweight. They are statistically treated as equal to someone with a BMI of 29 point 9. Biologically, this makes no sense. So, when you have continuous data, don't dichotomize it.


---
## Reducing levels of an already discrete variable

```yaml
type: "FullSlide"
key: "4f8c5d1bc5"
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
While converting a continuous variable to a discrete one is almost always discouraged, for variables that are already discrete, it may make sense to reduce their levels. There may already be too many levels in the variable, or doing so could simplify the interpretation. 

Let's look at job titles in the diet dataset. Using the count function on the variable, we can see there are three levels with a similar number of participants within each.


---
## Reducing levels of an already discrete variable

```yaml
type: "FullSlide"
key: "5755a8f678"
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
Since there are a large number of bank workers, we could reduce the job categories to either bank worker or not. Using the case underscore when function is one way to do this and is useful with more complicated categories. Case underscore when takes a condition on the left side of the tilde and the value on the right side. Here, exclamation mark equals means not equal to. Each condition follows the comma. The final condition for missing values should be formatted as shown here for character data. Now, we use count to check that the new variable was successfully changed.


---
## Tidying up a discrete variable

```yaml
type: "FullSlide"
key: "835b4136b8"
```

`@part1`
```{r}
library(forcats)
diet %>%
    mutate(job = fct_recode(job, 
        # new name = old name
        "Banker" = "Bank worker"
    )) %>%
    count(job)

#> # A tibble: 3 x 2
#>   job           n
#>   <fct>     <int>
#> 1 Driver      102
#> 2 Conductor    84
#> 3 Banker      151
```


`@script`
While case underscore when is very useful for many situations, the forcats package is best for tidying up discrete variables to work with factors specifically. The fct underscore recode function allows you to directly edit a level and rename it. Here, you list the new and old level names. This is a very quick way to work with factors!


---
## A short comment on outliers

```yaml
type: "FullSlide"
key: "d5dff5d251"
```

`@part1`
> Short answer: Do *not* remove outliers, unless the data is wrong {{1}}

&nbsp;

Longer answer: {{2}}

- Outliers contain valuable scientific information {{2}}
- Influence on statistical results, needs consideration and analysis {{2}}


`@script`
Let's briefly discuss dealing with outliers. You may read studies that remove outliers from their data. You should not do this unless the data itself is actually wrong, for example, data entry errors. Outliers on their own contain valuable scientific information, and they should be included in any analyses that you do.


---
## Lesson summary

```yaml
type: "FullSlide"
key: "d972cd44df"
```

`@part1`
- Don't discretize
- Keep continuous data continuous
- Use `count` to check categorical data 
- Use `case_when` or `fct_recode` to reduce levels
- Don't remove outliers, unless they are wrong


`@script`
In summary, keep continuous data continuous. Use count, case underscore when, and fct underscore recode functions to check and reduce categorical data. And lastly, keep outliers in your data.


---
## Let's tidy up the cohort dataset more!

```yaml
type: "FinalSlide"
key: "1eba1be603"
```

`@script`
Alright, let's do some tidying!

