---
title: Variable transformations
key: 5d026dadac109f3540f3c1f59a6f96ea

---
## Variable transformations

```yaml
type: "TitleSlide"
key: "51d2f0a99b"
```

`@lower_third`

name: Luke
title: Instructor


`@script`

Transforming your variables is a common activity when analyzing cohorts. In this lesson we will cover the why, what, and how of variable transformations.

---
## Why transform variables?

```yaml
type: "FullSlide"
key: "5dcb3a9bee"
```

`@part1`
- Transformation: The act of applying a mathematical function to data, often to change its distribution {{1}}
- Multiple reasons to transform variables: {{2}}
    - To fit with statistical assumptions
    - To convert to shared variable unit
    - To analyze for linear relationships
    - *To improve interpretation of model results*


`@script`
Transforming a variable is the act of applying some mathematical function to the variable, for instance, by dividing a variable by 10. There are many reasons to transform a variable. We transform to fit the variable distribution to some assumptions for a statistical technique. Or when you want several variables to have a common unit for easier comparison. Or when you want to examine linear relationships between two or more variables. Ultimately, you use transformations to make it easier to interpret the results of your analyses. In health research this is really important, as your results could be used to improve people's health.


---
## Common types of variable transformations

```yaml
type: "FullSlide"
key: "cb8a52378a"
```

`@part1`
- Think carefully about which to use {{1}}
- Depends on data, analysis, and eventual interpretation {{2}}

&nbsp;

| Type | R code | When to use |
|:-----|:-------|:------------|
| natural logarithm | `log(x)` | If highly right skewed, positive data |
| scaling | `scale(x)` | For same unit scale |
| square root | `sqrt(x)` | Great for count data, handles zeros |
| multiplicative inverse |`1 / x`| To invert values/unit, but no zeros | {{3}}


`@script`
There are many types of transformations. Which one to use depends on your data, on your choice of statistics, and how you want the results to be interpreted. Here is a table of some common transformations. A common transformation is the natural logarithm. You use it when your data is highly right-skewed or when you want your regression results to be interpreted as a percent change. Another common transformation is scaling, which is when the values are substracted by the mean and divided by the standard deviation. This results in a value of, for instance, +1 being a "1 SD increase". This is useful when you have variables with different units (kilogram or meters) or different sizes of a unit (meters of a person vs an elephant). After scaling, you can compare these variables more easily. 

---
## Transforming your data in R

```yaml
type: "FullSlide"
key: "80913fa973"
```

`@part1`
```{r}
transformed <- diet %>%
    mutate(weight_log = log(weight),
           ...,
           height_log = log(height)
           )
``` {{1}}

&nbsp;

```{r}
transformed <- diet %>%
    select(height, weight) %>% 
    mutate_at(vars(weight, height), 
              funs(scale, log))

names(transformed)
#> [1] "height"       "weight"       "weight_scale"
#> [4] "height_scale" "weight_log"   "height_log"  
``` {{2}}

`@script`
With the mutate function from dplyr, transforming is easy! A typical way of adding a column is shown here. You create the new column with the log of the original values. If you have many variables and many transformations, this gets tedious. A faster way is to use the mutate_at function. It takes two arguments: the variables with the vars function, and the transformation functions with the funs function. Mutate_at appends the transformation function name to the end of the variable name. You now have transformed all these variables!

---
## Visualizing the transformations

```yaml
type: "FullImageSlide"
key: "f1d0ec80d5"
```

`@part1`
![Transformation distributions](http://assets.datacamp.com/production/repositories/2079/datasets/a2a1cc3b6769cb841ba7905f473f842cbc5f5e24/plot_transform_weight.png)


`@script`
Let's take a look at what the transformations do. First, check how scaling doesn't really change the distribution, but now the middle is more or less at zero and the units are interpreted as "standard deviations from the mean". Compare this to the logarithm. In this particular example it doesn't change the distribution, however in general it can strongly shrink the distribution. Finally, see how the inverse literally inverts the distribution. But notice the units and consider how this influences the interpretation in later analyses.

---
## Lesson summary

```yaml
type: "FullSlide"
key: "cadb2ff612"
```

`@part1`

- Transform for many reasons, with many choices
    - Be thoughtful and careful about the why
- Common ones include `log()` and `scale()`
- Transforms can strongly influence the distribution

`@script`

In this lesson we covered some of the reasons to use transformations and some common types, such as the log or scaling. As always, be careful and thoughtful about using transformations. Your findings may influence health of real humans... and if you aren't careful, you could end up causing harm because of unintented miscommunication.

---
## Let's practice transforming some variables!

```yaml
type: "FinalSlide"
key: "9da01b4e1a"
```

`@script`

Alright, let's get started with practicing these transformations!
