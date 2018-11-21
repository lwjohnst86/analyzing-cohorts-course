---
title: "Adjustment, confounding, and models"
key: 911feb6e308d8e7e180f7f33f32a51ed

---
## Adjustment, confounding, and models

```yaml
type: "TitleSlide"
key: "9f03a6de45"
```

`@lower_third`
name: Luke Johnston
title: Instructor


`@script`

*Content*:


ideas:
This is one of the trickiest part of the analysis... building a model to control
for potential confounders. 

The first step to identifying variables to adjust for comes from seeing what others
do to control for confounding and to consult with people who have a strong biological background knowledge of the area of research.

quote about : all models are wrong.. some are useful. ... ?

Show daggity?

---
## Creating models: Controlling for confounding

```yaml
type: "FullSlide"
```

`@part1`

- **Very difficult** to completely control for confounding
- Danger of not adjusting: Simpson's Paradox
    - Could lead to actual harm if not consider confounding
- Three common empirical and systematic approaches to identifying confounders:
    - Literature, biological rationale, background knowledge
    - Causal pathways: Directed acyclic graphs (DAG)
    - Model selection: Information criterion methods


`@script`

What does it mean to "adjust" for confounders? What is a confounder? You will have likely encountered confounding in one of the other epidemiology courses, so I won't cover it too much here. For cross-sectional analyses, adjusting for confounding is fairly easy, since there is no time-component. But in cohort datasets, confounding get a bit trickier and a little bit more thought needs to go into what to adjust for. And you are guaranteed to miss or not know about potential confounders. As the saying goes "All models are wrong, but some are useful".

Like all health research, considering confounders is very important. If you don't you may encounter a problem known as Simpson's Paradox, which we will cover in the next slide. There are several ways of identifying confounders. Some common and more appropriate methods include using previous knowledge of biology and of the problem, and using more formal mathematical methods such as directed acyclic graphs and information criterion techniques.

---
## What is confounding? An example using Simpson's Paradox

```yaml
type: "FullSlide"
```

`@part1`



`@script`

For detecting Simpson's paradox, see Simpsons package.

---
## Classical definition of a confounder?

```yaml
type: "FullSlide"
```

`@part1`

![DAG](datasets/ch3-v2-classic-confounder.png)

- This graphic is called a *directed acyclic graph*

`@script`

This simple confounding example shows how each variable relates to each other in
hypothesized pathways. Understanding how variables confounded the relationship
between the exposure and the outcome is essential to drawing more accurate
inferences about the associations. Creating these DAGs of the hypothesized
pathways is a powerful tool to understanding what could be confounders, what
could be colliders, and what needs to be adjusted for. Which are more
appropriate choices:

The below diagram is a classic example of what confouding is. When a variable is 
linked in some way, either directly or indirectly, to both the exposure and the 
outcome, it is considered a confounder.



---
## What is a directed acyclic graph?

```yaml
type: "FullSlide"
```

`@part1`



`@script`

---
## Identifying adjustment with the dagitty package

```yaml
type: "FullSlide"
```

`@part1`



`@script`

---
## Assessing model fit: Akaike information criterion (AIC)

```yaml
type: "FullSlide"
```

`@part1`



`@script`

---
## Model selection using the MuMIn package

```yaml
type: "FullSlide"
```

`@part1`



`@script`

Note: be careful using this dredge function with too many variables

also, don't rely on this function

Information criterion such as Akaike Information
Criterion (AIC) are used to balance good model fit with low model complexity
(i.e. less variables adjusted for). 

---
## Adhering to guidelines: STROBE

```yaml
type: "FullSlide"
```

`@part1`

> The STROBE Statement: STrengthening the Reporting of OBservational studies in Epidemiology

www.strobe-statement.org


`@script`

---
## Insert title here...

```yaml
type: "FullSlide"
```

`@part1`



`@script`


---
## Insert title here...

```yaml
type: "FullSlide"
```

`@part1`



`@script`



---
## Final Slide

```yaml
type: "FinalSlide"
key: "8f38e0afcc"
```

`@script`


