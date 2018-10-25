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

Transforming your variables is a very common activity when analyzing cohort data. In this lesson, we will cover why you might need to transform your variables, what type of transformations are available, and how they change your data.

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
Transformations are powerful tools when doing data analysis. Transforming a variable is the act of applying some mathematical function, for instance dividing all values by 10 or calculating the percentage. Oftentimes, transformations are used to change the shape of the distribution. There are many reasons to transform a variable. You use transformations to fit the variable to assumptions of a statistical technique. Or when you have several variables with different units (for instance, kilograms and meters), but want the variables to have a common or shared unit. Or when you want examine if there is a linear relationship with two or more variables, so you need to first transform to fit the statistical formula to test that linearity. But ultimately, you use transformations in order to make it easier to interpret the results of any analyses you do. And in health research, this is really really important, as your research results could be used to try to improve people's health.


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
| natural log | `log(x)` | If highly right skewed, positive data |
| scaling | `scale(x)` | For same unit scale |
| square root | `sqrt(x)` | Great for count data, handles zeros |
| multiplicative inverse |`1 / x`| To invert values/unit, but no zeros | {{3}}


`@script`
There are so many ways to transform your variables. Which transformation to use depends heavily on what your data looks like, which statistical analysis you use, and how you want the results to be interpreted. Here is a list of some common transformations to use, how and when to use it, and how to interpret the results. One of the most common transformation is the natural logarithm. It is used if you have highly right skewed data or if you want your final regression results to be interpreted as percent change. Another very common transformation is to scale your variables. Scaling is when you substract the mean of the value and divide by the standard deviation. You end up with a value of +1 being represented as a "1 SD increase". This is very useful when you have many variables with either different units (for instance kilogram or meters) or different size of a common unit (for instance, meters of a person vs meters of an elephant). When you scale, your results using these variables can now be interpreted between each other.

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
You can transform your variables easily using dplyr. Here is the typical way of adding a column such as the data transformation to your dataset with dplyr. You create the column by naming it, for instance here with creating the log of weight or of height. However, this gets tedious very quickly. Instead, the faster way is to use the mutate_at function. It takes two arguments, the variables with the vars function, and the functions to use to transform with the funs function. Then it appends the name of the transformation function to the end of the variable name. This is a quick way to use many transformations on many variables. 

---
## Visualizing the transformations

```yaml
type: "FullSlide"
key: "f1d0ec80d5"
```

`@part1`
![Transformation distributions](http://assets.datacamp.com/production/repositories/2079/datasets/a2a1cc3b6769cb841ba7905f473f842cbc5f5e24/plot_transform_weight.png)


`@script`
These figures show how the distribution and unit changes depending on the transformation. See how scaling doesn't really change the distribution, but now the middle is more or less at zero and the units are interpreted as "standard deviations". Compare this to the logarithm. In this example it hasn't change the distribution too much, but in general it can make distributions much tighter. Lastly, see how the invert literally inverts the distribution. But pay attention to the unit, as it will be difficult to interpret after you do some later analyses.

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

In this lesson we covered some of the reasons to use transformations and some of the types to choose from, such as the natural log or scaling. In all cases, especially in health research, be very careful and thoughtful about why you want to use transformations and which ones you choose. Your findings may be used to influence health of real human beings... and if you aren't careful, you could end up harming thousands of people or more.

---
## Let's practice transforming some variables!

```yaml
type: "FinalSlide"
key: "9da01b4e1a"
```

`@script`

Alright, let's get started with practicing these transformations!
