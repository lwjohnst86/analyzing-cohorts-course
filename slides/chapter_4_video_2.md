---
title: Communicating cohort findings through graphs
key: d22c077f314d124f7ab5f28fa0423465

---
## Communicating cohort findings through graphs

```yaml
type: "TitleSlide"
key: "33450ca514"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
In the past, most results from cohort studies were presented as tables. However, for most types of data, tables are an ineffective way at communicating findings. Even now, cohort results are still presented as tables, mainly due to tradition and to lack of awareness and skill in creating effective and meaningful graphs.


---
## Figures should be *preferred* over tables

```yaml
type: "FullSlide"
key: "ec5e4806ba"
```

`@part1`
Why? Humans are visual, graphs are visual

- Easier to interpret {{1}}
- More information per space {{1}}

When? {{2}}

- Units are mostly same {{2}}
- Emphasize patterns {{2}}
- Items are compared {{2}}
- Lots of data to show {{2}}


`@script`
When deciding on how you will present your results, you should first think of how to put your data as a graph. Graphs are an incredibly powerful way of communicating scientific findings. Because we as humans heavily rely on our visual system, using graphs leverages this system. Graphs are easier to interpret than tables and allow for more information per space of paper or screen. 

Graphs are especially useful when units of measure are the same or similar, when you want to focus on patterns or need to compare items, and particularly when there is a lot of data to show.


---
## Comparison of presentation: Figure vs table

```yaml
type: "FullSlide"
key: "a7cc464036"
```

`@part1`
|Predictor |Estimate (95% CI) |
|:---------|:-----------------|
|energy    |0.9 (0.8, 1)      |
|fibre     |0.3 (0.1, 0.7)    |
|fat       |0.8 (0.7, 0.9)    | {{1}}

![Plot of models](https://assets.datacamp.com/production/repositories/2079/datasets/a3db1948e53a0be132489e15a6a60e6134d4a202/ch4-v2-models.png) {{2}}


`@script`
Let's compare the same results presented as a table or as a plot. Here we have the results from three models showing estimates for the three predictors. You can probably already tell that you will have to take some time to interpret what the results mean and how they compare to each other.

Now, the same results as a plot. Immediately you get a very quick sense of the results, their magnitude, direction of association, and comparison with the other findings. You don't have to work so hard to understand what the results are saying. This is the point and reason to prefer using plots over tables.

If you recall from chapter 3, there are dozens of statistical techniques and approaches to analyzing cohort data. What technique you use will determine what plots you can make. However, a common output of an analysis is some type of regression-type estimate and a measure of precision such as a confidence interval. So this plot shown here is a good way of showing these types of results. So from now on, we will be covering how to create these.


---
## Plotting estimates and confidence intervals

```yaml
type: "FullSlide"
key: "efa5ebbadc"
```

`@part1`
```{r}
estimate_ci_plot <- models %>%
    filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh() +
    geom_vline(xintercept = 1)
estimate_ci_plot
```

![Plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/888f76bf313121b29a3fb1051bb4480c5ea9c3e8/ch4-v2-estimate-ci-basic.png)


`@script`
We can make this type of plot by using geom point, geom errorbar (the horizontal version), and geom vline. In this case, each item on the y axis is an individual model's predictor and on the x axis is the estimate, as odds ratios, and confidence interval from the model. Since the so called null line is at 1 for odds ratio values, we need to set the xintercept to 1. When you have many more model results to show, you can see how this plot would be able to easily show all the models at once. This is important to give a bigger picture view of the findings and it makes it easy to show the magnitude and direction of associations. This plot has a few ugly things about it. Let's fix it up.


---
## Plotting estimates and confidence intervals

```yaml
type: "FullSlide"
key: "2dc9c7824c"
disable_transition: true
```

`@part1`
```{r}
estimate_ci_plot_nicer <- models %>%
    filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) + # Reduce width of end bars
    geom_vline(xintercept = 1, linetype = "dashed") # Line contrast with others
estimate_ci_plot
```

![(Slightly nicer) plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/47f4700950e9480cd25d630861b12c9efe06d21d/ch4-v2-estimate-ci-nicer.png)


`@script`
If we reduce the height of the error bar ends and make the center line dashed so it is differentiated from the other elements of the plot, the plot looks much better.


---
## Unadjusted and adjusted models in a single plot

```yaml
type: "FullSlide"
key: "2769fc30b4"
```

`@part1`
**STROBE**: Give unadjusted and adjusted estimates

```{r}
unadjusted_adjusted <- models %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed") +
    facet_grid(rows = vars(model))
unadjusted_adjusted
```

![Showing both unadjusted and adjusted results](https://assets.datacamp.com/production/repositories/2079/datasets/9863889fd3985923a46e4ec06beb37822cb83af0/ch4-v2-unadjusted-adjusted.png)


`@script`



---
## Got an interaction? Show what it looks like!

```yaml
type: "FullSlide"
key: "6231c20cd6"
```

`@part1`



`@script`



---
## Sensitivity analysis? Show it too!

```yaml
type: "FullSlide"
key: "3d3edd3bd4"
```

`@part1`
**STROBE**: Report on sensitivity analyses


`@script`



---
## Final Slide

```yaml
type: "FinalSlide"
key: "dced2a4c4a"
```

`@script`


