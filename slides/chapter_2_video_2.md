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
Cohort datasets often contain many discrete variables, for example with data obtained from questionnaires. In this lesson, you'll learn when and how to tidy up discrete data.


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
But first I want to mention a problem common in health research, known as dichotomania. Dichotomania is an obsession to convert continuous data into discrete data. It is also called discretizing or dichotomizing. For example, obesity is defined as a BMI greater than thirty.


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
Discretizing can cause a lot of problems. For instance it reduces statistical power, provides little clinical value, and there is a higher chance of misclassifying an individual's health risk. So, avoid it as much as you can.


---
## The problem of discretizing: An visual example

```yaml
type: "FullSlide"
key: "cbfac7ce3a"
```

`@part1`
| Category | BMI range |
|:---------|:----------|
| "Underweight" | < 18.5 |
| "Normal weight" | 18.5 - 25 |
| "Overweight" | 25 - 30 |
| "Obese" | > 30 | 
{{1}}
&nbsp;

```{r}
# For next figure:
tidier_framingham %>%
    ggplot(aes(x = body_mass_index)) +
    geom_histogram(colour = "black", fill = "grey80") +
    geom_vline(xintercept = c(20, 25, 30), linetype = "dashed")
```
{{2}}


`@script`
You may be familiar with the different weight classes used according to your body mass index, or BMI. These classes, shown in the table, are often used in health research. Let's visually show why this is a problem. The code provided creates the image shown next.


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
BMI continuously occurs at every value from 10 to more than 60. The three vertical lines are when discretization is applied to the data. Huge chunks of people are classified with others even if they are very close to one of the lines. For instance, someone with a BMI of twenty would be classified equally as someone with a BMI of twenty-four point nine. Or, if someone gains a BMI of zero point two, they could move from one category to the next. Biologically, this makes no sense. So, as best you can, avoid dichotomizing variables!


---
## Reducing levels of naturally discrete variables

```yaml
type: "FullSlide"
key: "2849fc21a2"
```

`@part1`
- Naturally/generally discrete: Usually no fractions {{1}}
    - "Pills taken": 1 or 2 pills, but not 1.5

- Reasons to reduce: {{2}}
    - Large error in measurement, e.g. "Eggs eaten daily?"
    - Data entry errors
    - Small sample sizes in some levels
    - Ease of interpretation


`@script`
While discretizing a continuous variable is often discouraged, some variables tend to be more naturally discrete. For example, you usually take one or two pills, not one point five. Sometimes, reducing the number of levels in these discrete variables makes sense, such as when there is large error in measurement or data entry, small sample sizes in some levels, or easier interpretation.


---
## Reducing levels of naturally discrete variables

```yaml
type: "FullSlide"
key: "257a8a9d31"
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
Let's use cigarettes per day as an example and use the count function on the variable. We can see that the values are integers. People usually report smoking one or two, not one and a half. From the previous exercise you'll have seen that more people report a rounded or estimated number, such as about ten or fifteen, but rarely numbers like seventeen. And because there are few people in any given integer, we could simplify the variable.


---
## Reducing levels of a discrete variable

```yaml
type: "FullSlide"
key: "c19e59fea5"
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
We can tidy up and reduce a variable's levels by using the case-underscore-when function from dplyr. Since packs of cigarettes usually come with 20 cigarettes, let's create another variable for number of packs smoked. Case-underscore-when takes multiple arguments, each is in the form of a condition on the left of the tilde and the output value on the right. So we set the first condition as when cigarettes is zero and assign the value none. The next is when cigarettes is from one to twenty, assigning the value up to one, and so on. The final condition should be formatted as shown when outputting characters. When counting the new variable, it now has less levels.


---
## Further tidying up

```yaml
type: "FullSlide"
key: "03afb9f460"
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
Case when is useful for many situations, but the forcats package is specific to tidying up factor variables. Use the fct-underscore-recode function to edit and rename levels directly. The argument has the form of the new level name then equals old names. In this case, we now merged two levels together.


---
## Lesson summary

```yaml
type: "FullSlide"
key: "d972cd44df"
```

`@part1`
- Don't discretize, keep continuous data continuous
- Use `count()` to check categorical data 
- Use `case_when()` or `fct_recode()` to reduce levels


`@script`
In summary, keep continuous data continuous. Use count, case-underscore-when, and fct-underscore-recode functions to check and reduce categorical data.


---
## Let's tidy up the cohort dataset more!

```yaml
type: "FinalSlide"
key: "1eba1be603"
```

`@script`
Alright, let's do some tidying!

