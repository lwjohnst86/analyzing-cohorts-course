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
Traditionally, results from cohort studies were presented as tables. However, tables are not really effective at communicating findings.


---
## Figures should be preferred over tables

```yaml
type: "FullSlide"
key: "ec5e4806ba"
```

`@part1`
*Why?* Humans are visual, graphs are visual

- Easier to interpret {{1}}
- More information per space {{1}}

*When?* {{2}}

- Units are the same/similar {{2}}
- Emphasize patterns or comparisons {{2}}
- Lots of data to show {{2}}


`@script`
When deciding how to present your results, you should first think of how to graph your data. Graphs are incredibly powerful at communicating information because they leverage our reliance on our visual system. Graphs are easier to interpret than tables and allow for greater information transmission. 

Graphs are especially useful when units of measure are the same or similar, when you want to emphasize patterns or comparisons, and when there is a lot of data to show.


---
## Comparison of presentation: Figure vs table

```yaml
type: "FullSlide"
key: "a7cc464036"
center_content: true
```

`@part1`
|Predictor |Estimate (95% CI) |
|:---------|:-----------------|
|energy    |0.9 (0.8, 1)      |
|fibre     |0.3 (0.1, 0.7)    |
|fat       |0.8 (0.7, 0.9)    | {{1}}

![Plot of models](https://assets.datacamp.com/production/repositories/2079/datasets/b3b869e4018df3d0b1d3d1fa6d09e9243014a5d7/ch4-v2-models.png) {{2}}


`@script`
Let's use an example to illustrate the power of graphs. Here we have the estimates for three predictors from three models. Reading this table takes some time, as you need to conceptualize how each item compares.

Now, let's see the information as a plot. You can quickly get a sense of the results, the magnitude, direction of association, and how they compare. You don't work as hard to understand the results, which is why plots are preferred to tables.

I mentioned in chapter 3 that there are dozens of statistical techniques for analyzing cohort data. The technique you use will determine the plots you make. A common analysis output is some type of regression-based estimate and measure of precision, like confidence intervals, which this plot shows effectively.


---
## Plotting estimates and confidence intervals

```yaml
type: "FullSlide"
key: "efa5ebbadc"
```

`@part1`
```{r}
models %>%
    filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, 
               xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh() +
    geom_vline(xintercept = 1)
```
{{1}}

![Plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/b8e940652d8d23203849a7d0c480df2f0637636a/ch4-v2-estimate-ci-basic.png) {{2}}


`@script`
We can make this plot using geom-underscore-point, the horizontal geom-underscore-errorbar, and geom-underscore-vline. Each item on the y axis is a single model's predictor and associated estimate, as an odds ratio, and confidence interval. Since the null line is at one for odds ratios, we need to set the x-intercept to one. When you have many model results, this plot can easily show all the models at once, which gives a bigger picture of the findings and makes it easier to compare predictors. Let's fix up the plot.


---
## Plotting estimates and confidence intervals

```yaml
type: "FullSlide"
key: "2dc9c7824c"
disable_transition: true
```

`@part1`
```{r}
models %>%
    filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, 
               xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) + 
    geom_vline(xintercept = 1, linetype = "dashed")
```

![(Slightly nicer) plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/ebfbdaf24bb53af9e73b35720776d1d277fadd8e/ch4-v2-estimate-ci-nicer.png) {{1}}


`@script`
By reducing the height of the errorbar ends and making the center line dashed to differentiate it from the other plot elements, the plot will look much better.


---
## Unadjusted and adjusted models in a single plot

```yaml
type: "FullSlide"
key: "2769fc30b4"
```

`@part1`
```{r}
models %>%
    ggplot(aes(y = predictor, x = estimate, 
               xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed") +
    facet_grid(rows = vars(model))
```
{{1}}

![Showing both unadjusted and adjusted results](https://assets.datacamp.com/production/repositories/2079/datasets/24698332a3e01046dafd90cf1dca391c3a10aa92/ch4-v2-unadjusted-adjusted.png) {{2}}


`@script`
As stated in the STROBE guidelines, you should always show both unadjusted and adjusted model results. Showing both on a single plot is easy to do if your data is properly set up. With all model adjustment types in a single dataframe, you can plot the unadjusted and adjusted models by splitting them using facet-underscore-grid. The vars function lets the model variable to be passed to ggplot. Here, using vars, the rows argument indicates that the model groups should be vertically stacked rather than side by side as columns.


---
## Got an interaction? Plot it

```yaml
type: "FullSlide"
key: "6231c20cd6"
```

`@part1`
- *Any interaction should be plotted* {{1}}
    - Simplifies interpretation
    - Should be main focus of findings
- **But**, interactions are hard {{2}}
    - Easy to model, difficult to visualize
- Found an interaction? {{3}}
    - Get specialized training or support


`@script`
Interactions are an extremely valuable source of scientific information and they need to be visualized to simplify the conceptually difficult interpretation. Although modeling interactions is easy, as we discussed previously, visualizing them can be incredibly difficult and time-consuming. Visualizing interactions is heavily dependent on the statistical modeling technique used, and this could be the topic of an entire course. This course will not go into much detail about specific techniques, so if you have an interaction in your data, be sure to get specialized training or support to make sure you correctly visualize it.


---
## Plotting time!

```yaml
type: "FinalSlide"
key: "dced2a4c4a"
```

`@script`
Excellent, let's practice some of these skills.

