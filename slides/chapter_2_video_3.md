---
title: Insert title here
key: 5d026dadac109f3540f3c1f59a6f96ea

---
## Transforming and modifying variables

```yaml
type: "TitleSlide"
key: "51d2f0a99b"
```

`@lower_third`

name: Luke
title: Instructor


`@script`

- DON't Dichotomize!!
    - Don't convert continuous to discrete. There could be non-linear relationships
    - eg with BMI or age...
- Categorical variable modication:
    - sometimes some categories are too small, so sometimes for model
    interpretation and generalizability, grouping categories makes sense,
    and to also balance the sample between groups.



---
## Transforming variables

```yaml
type: "FullSlide"
```

`@part1`

- Multiple reasons to transform variables:
    - To fit with statistical assumptions
    - To improve interpretation of model results
    - To convert to shared variable unit


`@script`

- Transformation can be used to correct "violations in regression
assumptions", but this is not often important or necessary.
- Use transformations such as log if the variable is unitless, or there is
disagreement between studies on the specific unit, or if the unit value
varies between studies. That way the result is interpreted in a way that 
can be compared to previous and future studies.


---
## Common types of variable transformations

```yaml
type: "FullSlide"
```

`@part1`

| Type | R code | When to use |
|:-----|:-------|:------------|
| natural log | `log(x)` | |
| log 10 | `log10(x)` | |
| scaling | `scale(x)` | |
| mean-center | `scale(x, scale = FALSE)` | |



`@script`

- Types of transformations and why to use them:
    - Log: if data is highly skewed, if interested in output after
    backtransforming of percent impact rather than on original unit impact
    (often used)
    - square root?: ... (rarely done)
    - scaled: Put variables on same scale/unit (all become SD, fairly common)

example of when to use log?

http://fmwww.bc.edu/repec/bocode/t/transint.html

---
## Final Slide

```yaml
type: "FinalSlide"
key: "9da01b4e1a"
```

`@script`


