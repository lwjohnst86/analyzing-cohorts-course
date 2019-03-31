---
title: Tidying discrete data for later analysis
key: 4e1f8ff56b37d8caee655cf2b0b4639d

---
## Discrete data and tidying it for later analysis

```yaml
type: "TitleSlide"
key: "edbfed5a7c"
```

`@lower_third`

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
Cohort datasets often contain many discrete variables, for instance like data obtained from questionnaires. In this lesson, we will discuss when and how to tidy up discrete data.


---
## A comment on "dichotomania"

```yaml
type: "FullSlide"
key: "f3f4f626e0"
```

`@part1`
> Dichotomania: The obsession to convert continuous data into discrete or binary data {{1}}

- Also called discretizing or dichotomizing {{2}}
- Example: obese = body mass index > 30 {{3}}


`@script`
Before continuing, I want to talk about a problem common in health research, which is known as dichotomania. Dichotomania is an obsession researchers have with converting continuous data into discrete or binary data. These processes are known as discretizing or dichotomizing. An example of this is the definition of obesity, which is any BMI greater than 30.


---
## Don't discretize continuous data

```yaml
type: "FullSlide"
key: "e382f259fd"
disable_transition: true
```

`@part1`
- Discretizing: {{1}}
    - Reduces statistical power
    - Little clinical value
    - Higher misclassification
    - Should be avoided {{2}}


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
tidier_framingham %>%
    ggplot(aes(x = body_mass_index)) +
    geom_histogram(colour = "black", 
                   fill = "grey80") +
    geom_vline(xintercept = c(20, 25, 30), 
               linetype = "dashed")
```
{{1}}


`@script`
For example, you may be familiar with the different weight classes based on your body mass index, or BMI. These weight classes, shown in the table, are often used in health research and show why discretizing is a problem. Let's plot BMI from the diet cohort. This code will create the image shown next.


---
## The problem of discretizing: An visual example

```yaml
type: "FullSlide"
key: "3b16cf3f48"
disable_transition: true
```

`@part1`
![Discretizing a continuous body mass index](https://assets.datacamp.com/production/repositories/2079/datasets/bbc561913da156d767e3f93d28184643fe969ce5/ch2-v2-discretising.png)


`@script`
Here we see how continuous BMI smoothly passes through each discrete category. Someone with a BMI of 24 point 9 would be classified as normal weight. If they gain a bit of weight and their BMI becomes 25 point 1, they would be classified as overweight. They are statistically treated as equal to someone with a BMI of 29 point 9. Biologically, this makes no sense. So, when you have continuous data, don't dichotomize it.

---
## Reducing levels of naturally discrete variables

```yaml
type: "FullSlide"
```

`@part1`
- Naturally/generally discrete: Usually no fractions {{1}}
    - "Pills taken": 1 or 2 pills, but not 1.5

- Reasons to reduce: {{2}}
    - Large error in measurement, e.g. "Eggs eaten daily?"
    - Small numbers in some levels
    - Ease of interpretation
    - Data entry errors

`@script`
While converting a continuous variable to a discrete one is almost always discouraged, for variables that are already discrete, it may make sense to reduce their levels. There may already be too many levels in the variable, or doing so could simplify the interpretation. 


---
## Reducing levels of naturally discrete variables

```yaml
type: "FullSlide"
```

`@part1`
```{r}
tidier_framingham %>%
    count(cigarettes_per_day)
```
{{1}}

```
# A tibble: 46 x 2
   cigarettes_per_day     n
                <dbl> <int>
 1                  0  6598
 2                  1   162
 3                  2    98
 4                  3   183
 5                  4    65
 6                  5   181
 7                  6    77
 8                  7    47
 9                  8    52
10                  9   149
# … with 36 more rows
```
{{1}}


`@script`
While converting a continuous variable to a discrete one is almost always discouraged, for variables that are already discrete, it may make sense to reduce their levels. There may already be too many levels in the variable, or doing so could simplify the interpretation. 

Let's look at job titles in the diet dataset. Using the count function on the variable, we can see there are three levels with a similar number of participants within each.

If you recall from when you plotted cigarettes per day, the distribution was quite jagged, with most people reporting for instance 15 or 20 cigarettes rather than a number like 18 or 17.


---
## Reducing levels of a discrete variable

```yaml
type: "FullSlide"
key: "5755a8f678"
```

`@part1`
```{r}
tidier_framingham <- tidier_framingham %>%
    mutate(cig_packs_per_day = case_when(
        cigarettes_per_day == 0 ~ "None",
        cigarettes_per_day >= 1 &
            cigarettes_per_day <= 20 ~ "Up to one",
        cigarettes_per_day >= 21 &
            cigarettes_per_day <= 40 ~ "One to two",
        cigarettes_per_day > 40 ~ "More than two",
        TRUE ~ NA_character_
    ))
tidier_framingham %>%
    count(cig_packs_per_day)

```
{{1}}

```
# A tibble: 5 x 2
  cig_packs_per_day     n
  <chr>             <int>
1 NA                   79
2 More than two       145
3 None               6598
4 One to two         1133
5 Up to one          3672
```
{{2}}


`@script`
Since there are a large number of bank workers, we could reduce the job categories to either bank worker or not. Using the case underscore when function is one way to do this and is useful with more complicated categories. Case underscore when takes a condition on the left side of the tilde and the value on the right side. Here, exclamation mark equals means not equal to. Each condition follows the comma. The final condition for missing values should be formatted as shown here for character data. Now, we use count to check that the new variable was successfully changed.


---
## Further tidying up

```yaml
type: "FullSlide"
key: "835b4136b8"
```

`@part1`
```{r}
library(forcats)
tidier_framingham %>%
    mutate(cig_packs_per_day = fct_recode(
        cig_packs_per_day, 
        # Form: "New level" = "Old level"
        "More than two" = "One to two"
    )) %>%
    count(cig_packs_per_day)
```
{{1}}

```
# A tibble: 4 x 2
  cig_packs_per_day     n
  <fct>             <int>
1 More than two      1278
2 None               6598
3 Up to one          3672
4 NA                   79
```
{{1}}


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

