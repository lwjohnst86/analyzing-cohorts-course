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
    - To analyze for linear relationships
    - To convert to shared variable unit
    - To improve interpretation of model results


`@script`
Transforming a variable is the act of applying a mathematical function to the variable. There are many reasons to transform a variable. We transform to fit the variable distribution to assumptions for a statistical technique, to examine linear relationships between variables, or create a common unit among variables for easier comparison. Ultimately, you use transformations to make it easier to interpret your analyses. This is particularly important in health research since your results could be used to improve people's health.


---
## Common types of variable transformations

```yaml
type: "FullSlide"
key: "cb8a52378a"
```

`@part1`
- Which to use depends on data, analysis, and desired interpretation {{1}}

| Type | R code | When to use |
|:-----|:-------|:------------|
| natural log | `log(x)` | Highly-right skewed, positive data |
| mean-center | `scale(x, scale = FALSE)` | Zero is the mean; use for easier interpretation |
| scaling | `scale(x)` | Same unit; be careful with longitudinal data |
| square root | `sqrt(x)` | Great for count data; handles zeros |
| inverse |`1 / x`| To invert values/unit, but no zeros | 
{{2}}


`@script`
There are many types of transformations. Which you use depends on your data, your choice of statistics, and how you want the results to be interpreted. Here is a table of a few common transformations. The natural logarithm is a very common transformation. You use it when your data is heavily right-skewed. Another common transformation is mean-centering, which is when the values are subtracted by the mean so zero represents the mean. Scaling is also fairly common, which is mean-centering and then dividing by the standard deviation. The square root is great for count data since it can handle zeros, unlike the natural logarithm or the inverse. The inverse, also called the reciprocal, is useful for several purposes, such as for reversing the unit. For instance, if a variable has the unit persons per doctor, the inverse is doctors per person.


---
## Transforming your data in R

```yaml
type: "FullSlide"
key: "80913fa973"
```

`@part1`
```{r}
# Typical way of transforming:
transformed <- tidier2_framingham %>%
    mutate(body_mass_index_log = log(body_mass_index_log),
           heart_rate_log = log(heart_rate))
```
{{1}}

```{r}
# More efficient way:
invert <- function(x) 1 / x
transformed <- tidier2_framingham %>%
    mutate_at(vars(body_mass_index, heart_rate),
              funs(scale, log, invert))
```
{{2}}

```
[1] "body_mass_index"        "heart_rate"          "body_mass_index_scale" 
[4] "heart_rate_scale"       "body_mass_index_log" "heart_rate_log"        
[7] "body_mass_index_invert" "heart_rate_invert"     
```
{{3}}


`@script`
With the mutate function from dplyr, transforming is easy! The typical way of creating new columns from transformations is to use mutate and create variables one by one. This gets tedious fast when there are many more transformations or variables. 

A faster way is to use the mutate-underscore-at function. It takes two arguments, the variables specified by the vars function, and the transformation functions specified by the funs function. 

Mutate-underscore-at appends the transformation function name to the end of the variable name. If a transformation function doesn't exist, I'd recommend creating a function of it so you can give it to the funs function and let mutate append the function name to the end. This is what we did with invert here. So, with only one or two lines of code, you've transformed all these variables!


---
## Visualizing the transformations

```yaml
type: "FullSlide"
key: "222e77d41e"
```

`@part1`
```{r}
# Long data and facets to show all plots
transformed %>%
    select(contains("heart_rate")) %>%
    gather(transformations, values) %>%
    ggplot(aes(x = values, y = stat(density))) +
    geom_histogram(colour = "black", fill = "grey80") +
    geom_density() +
    facet_wrap(vars(transformations), scales = "free")
```


`@script`
Let's look at what the transformations do. Here is the code that will create the next figure. Notice the contains function in select. This function finds all variables with this string. We'll plot both a histogram and a density curve. Since both geoms are used, we need to use the stat function with density as the y argument. We convert the data to long form and combine with facet as we've done previously, to plot each transformation.


---
## Visualizing the transformations

```yaml
type: "FullImageSlide"
key: "f1d0ec80d5"
```

`@part1`
![Transformation distributions](https://assets.datacamp.com/production/repositories/2079/datasets/5fe02fbe9ca848b638b67b889fbab70790958fc6/ch2-v3-transform-hr.png)


`@script`
Here are the plotted transforms. Notice how scaling doesn't change the distribution, but now the middle is approximately zero and the units are in standard deviations. Compare this to the logarithm, which shrinks the distribution, so more extreme values are closer to the middle. Finally, see how the inverse literally inverts the distribution. Larger heart rates are now small and small are large. Consider how which transform you use will change the units and, in later analyses, the interpretation.


---
## Lesson summary

```yaml
type: "FullSlide"
key: "cadb2ff612"
```

`@part1`
- Transform for many reasons, with many choices
    - Be thoughtful and careful about why
- Common ones include `log()` and `scale()`
- Transforms can strongly influence distribution


`@script`
To summarize, we covered when to use transformations and some common types, such as the log or scaling. As always, be careful and thoughtful about using transformations. Your findings may influence human health, so you must be sure to avoid possible miscommunication.


---
## Let's practice transforming some variables!

```yaml
type: "FinalSlide"
key: "9da01b4e1a"
```

`@script`
Let's practice these transformations!

