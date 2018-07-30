---
title: Introduction to cohort studies
key: fd067459a73b16863b609297f96ac32c


---
## Introduction to cohort studies

```yaml
type: TitleSlide
key: 0e5ec8f7ed
```

`@lower_third`
name: Luke Johnston
title: Instructor

`@script`

Hi! I'm Luke and I do research in diabetes epidemiology. I will be your
instructor for this course, where we will be going over how to analyze cohort 
datasets. In this chapter, we will be covering some of the basics of what a
cohort is, thoughts about the process of and typical steps involved in analyzing
cohort datasets, and some first steps in looking over the data.

---
## What is a cohort study?

```yaml
type: FullSlide
```

`@part1`

Features:

- Studies associations with (usually) disease
- Includes some time component to the data
- *Participants share common characteristic(s)*

![Example cohort recruitment and sample](datasets/plots-cohort-sample.pdf)

`@citations`

- Font Awesome Icons, created using R package emojifonts.

`@script`

Let's begin with the very basic. What does it mean that a study is a cohort
study? The cohort study design in general has a very specific features. For one,
cohorts usually are scientific studies to investigate how factors influence the 
risk for a disease. In cohorts, there is always a time component, as in there is
a temporal aspect to the data. And lastly, but most importantly, is that participants
in a cohort always share a common characteristic. For instance, in the Nurses'
Health Study from the United States, all participants are married female nurses.

---
## Purpose and usefulness of cohorts

```yaml
type: TwoRowsTwoColumns
key: 3020a2875a
```

`@part1`

![Risk factors and health management](datasets/plot-purpose-risk-factors.pdf)

`@part2`

![Informing diagnosis decisions](datasets/plot-purpose-diagnosis.pdf)

`@part3`

![Tracking side effects and safety from drugs](datasets/plot-purpose-side-effects.pdf)

`@part4`

`@citations`

- Font Awesome Icons, created using R package emojifonts.

`@script`

Cohort studies are fundamental to epidemiological research and a key design for
answering research questions about human health and behaviour. Cohort studies
are especially common in studies on health and disease, as they can be used to
identify risk factors for disease that can be targeted in prevention and disease
management strategies. They are also incredibly powerful for helping inform
evidence-based clinical decisions and for when watching for side effects from
new, or old, drugs.

---
## Two cohort study designs

```yaml
type: TwoColumns
key: 5a578ef6a6
```

`@part1`

#### Prospective

Study participants:

- Don't have the disease
- Looks forward in time:
    - Multiple visits over time
    - Health and other conditions measured at time visit
- Comparison group is those without the disease

`@part2`

#### Retrospective

Study participants:

- Have the disease
- Looks back in time:
    - Asked about past conditions
    - ...or past medical health records examined
- Needs a comparison group without the disease

`@script`

We will briefly go over the basics of cohort study designs in this lesson, but
will cover each design in more detail in later lessons. There are two cohort
study designs: prospective and retrospective. These two designs have many
similarities, but it is their differences that really sets them apart.

Prospective cohorts are by far the most common and most powerful form of cohort
for studying disease states, especially for diseases that are common (e.g.
diabetes). Retrospective cohorts are useful with rarer diseases, where health
records are easy to access, or when it is impractical or impossible to conduct a
prospective cohort.

---
## Why the basics are important to know

```yaml
type: FullSlide
key: d2a6af7c52
```

`@part1`

Why not just analyze the data? Why need to know the basics of cohorts?

- Type of cohort design restricts type of analysis and interpretation
    - Example: Retrospective cohorts often already have measured collected that
    are less detailed, so need to be very general and cautious in interpretation
- How and what variables were measured limit analysis and interpretation
    - Example: Some exposures/predictors are abstractions of underlying
    physiology, so need to transform variables so results are meaningful

`@script`

Given the rise in data science and machine learning, sometimes there is a pressure
or urge to just "throw variables into the model and let the data tell the story".
This is dangerous in many ways, especially when it comes to studies on health.
Because cohort studies often involve some disease, the results can have real world
impact on people's lives. So as the researcher, you need to know what data you are
dealing with and how it was collected in order to appropriately analyse and 
interpret the results. In the case of cohorts, the study design and types of 
variables measured influence how you do your data analysis. For instance, 
retrospective cohorts tend to have imprecise measures, so you have to be very
cautious about interpretation. Or there are some measures that abstractions of a
physiological process, so by transforming the variable you can have meaningful
results. This also means there are many many ways of analysing cohort datasets.

---
## Main goal of this course

```yaml
type: FullSlide
key: 5c430ef5dd
```

`@part1`

> **Learn the thought process, general analytic workflow, and main focus of doing and analyzing a cohort study... not to learn a specific statistical method.**

`@script`

... which brings me to the main goal of this course... we aren't going to cover
specific statistical techniques because cohorts and their analyses are so diverse.
So instead, we are going to focus on the overall workflow and process to looking
at, analysing, interpreting, and presenting results from cohorts.

---
## Let's try what we've learned!

```yaml
type: FinalSlide
key: 97f61fb6b7
```

`@script`

Alright, let's now do a few exercises to review and test your knowledge of
cohorts!
