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

This simple graphic illustrates the classic definition of what a confounder is. In this case, a confounder is some variable that can influence both the outcome and the exposure, either hypothetically, biologically, or informed from data exploration. Understanding confounded relationships between variables is essential to making more accurate inferences about the association of investigation. Creating these causal graphs, known as directed acyclic graphs or DAGs, is a powerful method to confounder identification.

---
## What is a directed acyclic graph?

```yaml
type: "FullSlide"
```

`@part1`

{{image of a dag with nodes and edges}}

`@script`

So, what is a DAG? 

---
## Identifying adjustment with the dagitty package

```yaml
type: "TwoColumns"
```

`@part2`

Height with colon cancer. But: {{1}}

- Men are taller {{2}}
- Men more likely to get cancer {{3}}
- Men tend to eat more meat {{4}}
- More meat, more likely to get colon cancer {{5}}

... Let's draw a DAG of this. {{6}}

`@part2`

```{r}
possible_confounders <- dagitty("dag {
    Height -> ColonCancer
    Sex -> {Height ColonCancer}
    Sex -> MeatIntake -> ColonCancer
}") {{7}}

adjustmentSets(possible_confounders,
               exposure = "Height",
               outcome = "ColonCancer") {{8}}
#>  { Sex } {{9}}
```

`@script`

Using the R package dagitty, you can create DAGs of possible confounders and it will suggest which variables you should adjust for. Let's take this example here. There is an association between taller height and a greater risk for cancers such as colon cancer. However, we know that men tend to be taller than women, that men tend to have a higher risk for cancer, that men tend to eat more meat, and that meat intake increases risk for colon cancer. So what do we need to adjust for? Let's draw a DAG with dagitty! The first argument for the dagitty function takes a character string of a DAG specification. We initialise with the keyword dag, and afterward list each corresponding link between variables. Here, height links with colon cancer, sex links with both height and colon cancer, and so on until all links are drawn. Then we use the adjustmentsets function, add the dagitty object, then we set which variable is the exposure and which is the outcome. After we run this, we get told that we need to adjust for at least sex. The dagitty package is very useful when you start getting more complicated pathways.

---
## Assessing model fit: Information criterion methods

```yaml
type: "FullSlide"
```

`@part1`

- Estimates relative model "quality" compared to other models. {{1}}
- Trade-off between the goodness of fit and simplicity (number of predictors). {{2}}
- Common method: Akaike information criterion (AIC). {{3}}
    - For models that use maximum likelihood (most regression-based methods).

`@script`

While the use of DAGs is a powerful tool to identifying potential confounders, I strongly recommend against using just one method to building a model. The main reason being is that you may not know all the potential links to include in the DAG. Another useful 

While using DAGs are a powerful

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

lower number is better

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


