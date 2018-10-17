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

- Or rather "coordinatized" data, so that each data value is unique and has a meaning.
- Tidy data, types of structure for type of analysis
- Longitudinal data in wide format
    - converting into long for use by statistical techniques (e.g. mixed effects)
    - talk about tidy data
TODO: More content, specific to cohorts.
For running models, each row should represent the all the values for one person
at one time point.
- How to wrangle the data to get into a form to use for the analysis/statistic
- Dealing with outliers (or not)

TODO: slide on `case_when` usage.

count(framingham, educ)
[1]  4  2  1  3 NA
> unique(framingham$sex)
[1] 1 2



---
## Final Slide

```yaml
type: "FinalSlide"
key: "1eba1be603"
```

`@script`


