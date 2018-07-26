---
title: Introduction to the datasets and exploring them
key: 9e3d8b35b89128ebb91908d3aa815cf1


---
## Introduction to the datasets and exploring them

```yaml
type: TitleSlide
key: 26a03a5d84
```

`@lower_third`
name: Luke Johnston
title: Instructor

`@script`

Before getting more into the dataset we will be using, we're going to quickly cover some more differences between prospective and retrospective cohorts. Since the dataset we are using is a prospective cohort, it's a good idea to highlight why a prospective cohort was chosen compared to a retrospective cohort.

{{Change lesson title? "Cohort types and introducing the dataset"}}

- General look of data:
    - Show how the data looks:
        - baseline visit with disease status followup (time to disease, or age
        at diagnosis, or age at death, etc)
        - multiple data collection waves (ID and Wave columns)
        - Data will look very similar between prospective vs retrospective, the
        difference being how the data was collected... need to check what the
        variables mean, so need to refer to the documentation.
    - State assumptions first about the data (e.g. data already collected), this
    is not a course on how to conduct and collect cohort data.
    

- Cohorts allow determining incidence, compared to prevalence

---
## Visual of the two cohort types

```yaml
type: FullSlide
```

`@part1`


`@script`

{{Visual of two types?}}

---
## Visual of a prospective cohort over time

```yaml
type: FullImageSlide
```

`@part1`

![Prospective cohort example visual]()

`@script`

{{image of what a prospective study looks like}}



---
## Framingham Heart Study

```yaml
type: FullSlide
```

`@part1`

```{r}
head(framingham)
```

`@script`

{{Include image from first paper on this? Or design paper?}}

`@citations`

- cite Framingham study

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

- Every field has their own naming convention for the variables of interest. In the case of cohorts, they are called "outcomes" for the y variable that is commonly seen in statistical notation, and "exposures" or "predictors" for the x variable in statistics.
- Like most data analyses, there is the variable you are interested in "predicting" or identifying risk for, and there is the variables that you think are what "predict" or influence in some way... the exposure to a condition that is thought to cause or to relate to the disease.



---
## Exploring dataset first 

```yaml
type: FullSlide
```

`@part1`

{{image here?}}

`@script`

Before doing any substantial tidying of the dataset, it's a very wise idea to quickly explore the data to get a sense of its structure, limitations, and strengths.

---
## Summary of lesson

```yaml
type: FullSlide
```

`@part1`

- Need to be aware of difference between prospective and retrospective cohort
    - The actual data will often look very similar
    - Need to refer to documentation extensively
- Need to recognize assumptions and limitations of dataset
- General overview of the Framingham Heart Study dataset
- Identified key feature of a cohort (aka a time component!)
- Name of variables of interest: outcome and exposure/predictor

`@script`

Let's review what we've covered so far. We talked about ...


---
## Let's practice!

```yaml
type: FinalSlide
key: ddbf9a5e1a
```

`@script`

Now it's your turn.

