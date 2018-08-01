---
title: Cohort types and introducing the dataset
key: 9e3d8b35b89128ebb91908d3aa815cf1


---
## Cohort types and introducing the dataset

```yaml
type: TitleSlide
key: 26a03a5d84
```

`@lower_third`
name: Luke Johnston
title: Instructor

`@script`

Before getting more into the Framingham dataset we will be using, we're going to
quickly cover some more differences between prospective and retrospective
cohorts. Since the dataset we are using is a prospective cohort, it's a good
idea to highlight why a prospective cohort was chosen compared to a
retrospective cohort.

---
## Comparisons between the two designs

```yaml
type: FullSlide
```

`@part1`

![Retrospective vs prospective cohorts](datasets/pro-vs-retro.png)

`@script`

As we previously covered, there are some important differences between
retrospective compared to prospective cohorts. The main difference is what point
the study starts relative to outcome occurance. In a retrospective cohort,
people are recruited based having the disease, then their data is collected from
past records. This is particularly common where data is collected in a frequent
or consistent context, such as in a hospital, so there is a data already
available. Prospective cohorts on the other hand have people who are recruited
because they don't have the disease and are followup either until they have the
disease or until the study ends. Data is collected as the time passes. Both
designs have their strengths and weaknesses. For instance, if you have easy
access to data that has already been collected by for example a hospital or a
by the government, or if the disease is really rare, retrospective cohorts are
very powerful scientific tools. However, there are many strengths to prospective
cohorts. They tend to be pretty common and to provide stronger evidence for
their results, simply because people are recruited without the disease. It is for
this reason that the Framingham prospective study was chosen.

`@citations`

- Euser et al, doi:10.1159/000235241

---
## How a prospective cohort looks like over time

```yaml
type: FullImageSlide
```

`@part1`

![Visual example of a prospective cohort](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/ff01e663a23c9cd65df9b4ddc46d5bc46b1647a6/prospective-cohort-visual-example.pdf)

`@script`

This is what a typical prospective cohort looks like. At study start, no one has
a disease. Each line is a hypothetical participant. As time passes, some people
get the disease and others don't. When the study ends or at the time of analysis,
there are a bunch of people who have gotten the disease and usually a lot more 
that didn't. We also have a bunch of data collected at several time points. So
now, you can compare how these two groups of people are different. What factors
distinguish those with compared to those without the disease? That is what we
try to answer when we analyze the data.

---
## What are the main variables of interest called?

```yaml
type: FullSlide
```

`@part1`

- *Outcome*: 
    - The disease or health state (e.g. cancer)
    - Commonly shown as the $y$ in regression analysis

- *Exposure/predictor*: 
    - Variable hypothesized to relate to a disease (e.g. tobacco smoking)
    - Commonly shown as the $x$ in regression analysis

`@script`

In every field of research, they have their own naming convention for the
variables of interest. In the case of cohorts, the term outcomes is used to 
mean the disease and is the y variable that is commonly seen in statistical
notation. The terms exposures or predictors represent the variables that relate
to or potentially influence the outcome in some way. We think of these as variables
that predict getting the disease or that if someone is exposed to that variable
(for instance, cigarette smoke), the risk for the disease increases or sometimes
may decrease.

---
## Framingham Heart Study

```yaml
type: TwoRows
```

`@part1`

![Original Framingham Heart Study publication](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/fb4a5797d1d3f1ea761ce274b23248e606775bf0/framingham-study.png)

`@part2`

```{r}
head(framingham)
```

```
# A tibble: 11,627 x 39
  randid   sex totchol   age sysbp diabp cursmoke cigpday   bmi diabetes
   <int> <int>   <int> <int> <dbl> <dbl>    <int>   <int> <dbl>    <int>
1   2448     1     195    39  106   70          0       0  27.0        0
2   2448     1     209    52  121   66          0       0  NA          0
3   6238     2     250    46  121   81          0       0  28.7        0
4   6238     2     260    52  105   69.5        0       0  29.4        0
5   6238     2     237    58  108   66          0       0  28.5        0
# ... with 29 more variables...
```

`@script`

Now we get to the Framingham study! This study was originally started in the 1950
and was first of its kind to investigate the role of lifestyle on cardiovascular
disease. Many health prevention tips, such as getting enough physical activity,
eating healthy foods, and not smoking, were first shown from the results of this
study. The study recruited more than about 5000 people, though in this teaching
dataset there are only about 4400 participants. Several variables as you can see
here were measured from the participants, many of whom came for 3 data
collection visits over around 15 years of followup. 

If you'll notice, there are some things in the dataset that aren't very clean...
for instance, the variable names aren't entirely clear and some values don't tell
us what they actually mean. Take the values in sex. What does 1 and 2 mean? So
we will need to do some tidying beforehand. However, before that, it's a very
smart idea to explore the data a bit to get a better sense of it.

`@citations`

- [Original paper on Framingham Study](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1525365/)
- [Framingham Heart Study Website](https://www.framinghamheartstudy.org/fhs-about/history/epidemiological-background/)

---
## Summary of lesson

```yaml
type: FullSlide
```

`@part1`

- Design types
    - Prospective: No disease, data collected as time passes
    - Retrospective: Disease at start, data obtained from past records
- Variables of interest
    - Outcome: Is the disease 
    - Exposure/predictor: Factor that is thought to influence the outcome
- Framingham cohort
    - ~3 time points, ~15 years
    - >4000 participants
    - Many possible predictors

`@script`

Before moving on, let's quickly review what we covered. We compared retrospective 
and prospective cohorts. The difference comes down to whether people have or don't 
have the disease at the start of the study. The terms for the variables are outcome
for the disease and exposure or predictor for the variables that might relate to
the outcome. Lastly, we briefly looked at the Framingham study, that has a large
number of participants, many years of followup, and many variables possible
predictors measured.

---
## Let's practice and explore the dataset!

```yaml
type: FinalSlide
key: ddbf9a5e1a
```

`@script`

Now, let's get to exploring the data!
