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
Traditionally, results from cohort studies were presented as tables. However, generally tables are not effective at communicating findings. Lack of awareness and training are the main reasons researchers continue to rely on tables for presentation.


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

- Units are mostly same {{2}}
- Emphasize patterns {{2}}
- Items are compared {{2}}
- Lots of data to show {{2}}


`@script`
When deciding on how to present your results, you should first think of how to graph your data. Graphs are incredibly powerful at communicating information because they leverage our innate human reliance on our visual system. Graphs are easier to interpret than tables and allow for greater information transmission. 

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

Now, as a plot. You can quickly get a sense of the results, their magnitude, direction of association, and comparison with the others. You don't work as hard to understand what the results are saying. This is the reason why plots are preferred over tables.

I mentioned in chapter 3 how there are dozens of statistical techniques for analyzing cohort data. What technique you use will determine the plots you make. However, a common analysis output is some type of regression-based estimate and measure of precision like confidence intervals, which this plot is effective at showing. So we will be covering how to create this plot.


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
We can make this type of plot by using geom point, the horizontal geom errorbar, and geom vline. Each item on the y axis is a single model's predictor and associated estimate, as an odds ratio, and confidence interval. Since the null line is at one for odds ratios, we need to set the xintercept to one. When you have many model results, this plot is able to easily show all the models at once. This gives a bigger picture view of the findings and makes it easy to compare predictors. This plot has a few ugly things about it. Let's fix it up.


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
As stated in the STROBE guidelines, you should always show both unadjusted and adjusted model results. Showing both on a single plot is easy to do if your data is properly set up. With all model adjustment types in a single dataframe, you can plot the unadjusted and adjusted models by splitting them using facet grid. In this case, the argument rows indicates that the model groups should be vertically stacked rather than side by side as columns. The vars function lets the model variable to be passed to ggplot.


---
## Got an interaction? Definitely plot it

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
    - Get specialized training or support.


`@script`
Interactions are an extremely valuable source of scientific information and they definitely need to be visualized to simplify the often conceptually difficult interpretation. But it gets tricky very quickly. Modelling interactions is easy, as we covered in chapter three. But visualizing them can be incredibly difficult and time consuming. Covering interactions could take nearly an entire course and visualizing them is heavily dependent on the statistical modelling technique used. This course is not designed to go into  much detail on a given technique, so if you do find an interaction in your data, get some specialized training or support to help you make sure you correctly visualize it.


---
## Plotting time!

```yaml
type: "FinalSlide"
key: "dced2a4c4a"
```

`@script`
Excellent, let's practice some of these skills.

