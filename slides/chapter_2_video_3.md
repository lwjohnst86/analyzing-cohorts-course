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

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
Transforming your variables is a common activity when analyzing cohorts. In this lesson we will cover the what, why, and how of variable transformations.


---
## Why transform variables?

```yaml
type: "FullSlide"
key: "5dcb3a9bee"
```

`@part1`
- Transformation: Applying math functions to data {{1}}
- Multiple reasons to transform variables: {{2}}
    - To fit with statistical assumptions
    - To convert to shared variable unit
    - To analyze for linear relationships
    - To improve interpretation of model results


`@script`
Transforming a variable is the act of applying a mathematical function to the variable, for instance, dividing a variable by 10. There are many reasons to transform a variable. We transform to fit the variable distribution to assumptions for a statistical technique, examine linear relationships between variables, or create a common unit among variables for easier comparison. Ultimately, you use transformations to make it easier to interpret analyses. This is particularly important in health research since your results could be used to improve people's health.


---
## Common types of variable transformations

```yaml
type: "FullSlide"
key: "cb8a52378a"
```

`@part1`
- Think carefully about which to use {{1}}
- Depends on data, analysis, and eventual interpretation {{2}}

| Type | R code | When to use |
|:-----|:-------|:------------|
| natural log | `log(x)` | Highly-right skewed, positive data |
| mean-center | `scale(x, scale = FALSE)` | Zero is the mean; use for easier interpretation |
| scaling | `scale(x)` | Same unit; be careful with longitudinal data |
| square root | `sqrt(x)` | Great for count data; handles zeros |
| inverse |`1 / x`| To invert values/unit, but no zeros | {{3}}


`@script`
There are many types of transformations. The one you should use depends on your data, choice of statistics, and how you want the results to be interpreted. Here is a table of a few common transformations. A common transformation is the natural logarithm. You use it when your data is heavily right-skewed or when you want your regression results to be interpreted as a percent change. Another common transformation is mean-centering, which is when the values are subtracted by the mean so zero represents the mean. Scaling is also fairly common, which is mean-centering and then dividing by the standard deviation. The square root is great for count data since it can handle zeros, unlike the natural logarithm or the inverse. The inverse, also called the reciprocal, is useful for several purposes, such as for reversing the unit. For instance, if a variable has the unit persons per doctor, the inverse is doctors per person.


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
           height_log = log(height)
           # Or more transformations
           )
``` {{1}}

```{r}
invert <- function(x) 1 / x
transformed <- diet %>%
    select(weight, height) %>%
    mutate_at(vars(weight, height), funs(scale, log, invert))

names(transformed)
#> [1] "weight"        "height"        "weight_scale"  "height_scale" 
#> [5] "weight_log"    "height_log"    "weight_invert" "height_invert"
``` {{2}}


`@script`
With the mutate function from dplyr, transforming is easy! The example here shows adding a column. You create the new column with the log of the original values. This can get tedious if you have many variables and many transformations. A faster way is to use the mutate underscore at function. It takes two arguments, the variables specified by the vars function, and the transformation functions specified by the funs function. Mutate underscore at appends the transformation function name to the end of the variable name. This is why you should create a transformation function if one doesn't already exist and use that function as the argument in mutate, which is what we did with invert here. With only one or two lines of code, you have now transformed all these variables!


---
## Visualizing the transformations

```yaml
type: "FullSlide"
key: "222e77d41e"
```

`@part1`
```{r}
# One plot for each transformation
ggplot(transformed, aes(x = weight, y = stat(density))) +
    geom_histogram(color = "black", fill = "lightyellow", size = 0.25) +
    geom_density()
```


`@script`
Let's look at what the transformations do. Here we'll show both the histogram and a density curve. Since both geoms are used, we need to use stat density as the y argument. We repeat this code for each transformation. Here, we are modifying color, fill, and line size to improve the visual of the plot on the next slide.


---
## Visualizing the transformations

```yaml
type: "FullImageSlide"
key: "f1d0ec80d5"
```

`@part1`
![Transformation distributions](http://assets.datacamp.com/production/repositories/2079/datasets/a2a1cc3b6769cb841ba7905f473f842cbc5f5e24/plot_transform_weight.png)


`@script`
Here are the plotted transforms. Notice how scaling doesn't change the distribution, but now the middle is approximately at zero and the units are interpreted as standard deviations. Compare this to the logarithm, which shrinks the range of the distribution, so more extreme values are closer to the middle. Finally, see how the inverse literally inverts the distribution. A large BMI is now small and small is large. Consider how the units change for all transforms and how interpretation will change in later analyses.


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
In this lesson, we covered some of the reasons to use transformations and some common types, such as the log or scaling. As always, be careful and thoughtful about using transformations. Your findings may influence human health, so you must be sure to avoid possible miscommunication.


---
## Let's practice transforming some variables!

```yaml
type: "FinalSlide"
key: "9da01b4e1a"
```

`@script`
Let's practice these transformations!

