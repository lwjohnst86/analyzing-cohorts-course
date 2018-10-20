---
title: Insert title here
key: 4e1f8ff56b37d8caee655cf2b0b4639d

---
## Tidy cohort data and wrangling into analyzable form.

```yaml
type: "TitleSlide"
key: "edbfed5a7c"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`

- DON't Dichotomize!!
    - Don't convert continuous to discrete. There could be non-linear relationships
    - eg with BMI or age...
    - unless data values look like it could or if a confounder in model.. (e.g. cigarettes)
    - show visual of why dich is wrong (point with colours of categories)
- Categorical variable modication:
    - sometimes some categories are too small, so sometimes for model
    interpretation and generalizability, grouping categories makes sense,
    and to also balance the sample between groups.
    - Use sex as an example

TODO: More content, specific to cohorts.
For running models, each row should represent the all the values for one person
at one time point.
- Dealing with outliers (or not)

TODO: slide on `case_when` usage.

count(framingham, educ)
[1]  4  2  1  3 NA
> unique(framingham$sex)
[1] 1 2

---
## "Dichotomania": A major problem in health research

```yaml
type: "FullSlide"
key: "edbfed5a7c"
```

`@part1`


> Dichotomania: The obsession to convert continuous data into discrete or binary data, also known as dichotomizing. For instance, obesity is defined as a body mass index of >30 while overweight is defined as between 25-30...

- Should be avoided at all costs
- Dichotomizing or discretizing:
    - Has no statistical utility
    - Has little to no clinical value
    - Misclassifies individuals
    - Reduces statistical power

`@script`

---
## The problem of discretizing: An visual example

```yaml
type: "FullSlide"
key: "edbfed5a7c"
```

`@part1`

- show example of dichotomizing or discretizing continuous data like BMI

`@script`

---
## 

```yaml
type: "FullSlide"
key: "edbfed5a7c"
```

`@part1`

`@script`

---
## Final Slide

```yaml
type: "FinalSlide"
key: "1eba1be603"
```

`@script`


