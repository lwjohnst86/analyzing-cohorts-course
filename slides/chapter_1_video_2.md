---
title: Cohort types, variables, and the Framingham Study
key: 9e3d8b35b89128ebb91908d3aa815cf1

---
## Cohort types, variables, and the Framingham Study

```yaml
type: "TitleSlide"
key: "26a03a5d84"
```

`@lower_third`

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
Before getting more into the Framingham dataset, we're going to quickly cover more differences between the two cohort types. Since Framingham is a prospective cohort, I'll highlight why a prospective cohort was chosen over a retrospective one for this course.


---
## Comparisons between the two designs

```yaml
type: "FullSlide"
key: "583fae4d2d"
```

`@part1`
![Retrospective vs prospective cohorts. ](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/a183894d11c7317da3f4831b9e6b75cb4929942d/pro-vs-retro.png)

Source from DOI: 10.1159/000235241


`@script`
We briefly covered the main difference between the two cohort types, specifically when the outcome occurs relative to the study start. In retrospective cohorts, people have the disease at the study start and their data is collected from past records. This is very common when data is collected frequently or consistently, such as in hospitals, and is easily available. 

In prospective cohorts, people don't have a disease at the study start. They are usually followed over time until the study end. Over time, more data is collected. Both designs have their strengths and weaknesses. If you have easy access to data already collected by a hospital or by the government, retrospective cohort designs are a very powerful scientific tool. But, there are many strengths to prospective cohort designs. They give stronger scientific evidence to research questions, because people are recruited without the disease. The Framingham dataset was chosen for this reason.


---
## How a prospective cohort looks over time

```yaml
type: "FullImageSlide"
key: "b7cc4ddc54"
```

`@part1`
![Visual example of a prospective cohort](https://assets.datacamp.com/production/repositories/2079/datasets/b5ecf50ee5eb89363a736373c556732dff9b0f59/ch1-v2-prospective-outcome.png)


`@script`
Here we see a typical prospective cohort. Each line is a hypothetical participant. At the study start, no one has a disease. As time passes, some people get the disease and others don't. When the study ends, or at the time of analysis, there are a group of people who have the disease, shown by the orange lines, and often a lot more who don't have the disease, shown by the blue lines. Data is also collected at several time points over the study period. So, you can compare how these two groups of people are different. What factors distinguish those with and without the disease? That is what we try to answer when we analyze the data.


---
## Main variables of interest

```yaml
type: "FullSlide"
key: "278d9126a9"
```

`@part1`
- *Outcome*: {{1}}
    - Disease or health state (e.g. cancer)
    - Commonly shown as the $y$ in regression analysis

- *Exposure/predictor*: {{2}}
    - Variable hypothesized to relate to a disease (e.g. tobacco smoking)
    - Commonly shown as the $x$ in regression analysis


`@script`
In cohort studies, there are commonly two terms used, outcome and exposure or predictor. 

The term outcome is used to mean the disease and it is the y or dependent variable commonly seen in statistical notation.

The term exposure or predictor represents the variables that relate to or potentially influence the outcome in some way. These are the variables that we think may predict whether someone gets the disease, for example, with cigarette smoke and lung cancer.


---
## Follow-up time in the prospective Framingham cohort

```yaml
type: "FullSlide"
key: "77bd85b3d8"
```

`@part1`
```{r}
library(dplyr)
framingham %>%
    select(followup_visit_number = period, days_of_followup = time)
    summarise(number_visits = max(followup_visit_number),
              number_years = round(max(days_of_followup) / 365, 1))
```
{{1}}

```
# A tibble: 1 x 2
  number_visits number_years
          <dbl>        <dbl>
1             3         13.3
```
{{2}}


`@script`
Let's look more at the data and find out how some details about years and visits. Using dplyr, we select and rename the visit variables. Then we use summarize to find the maximum number of visits and years of followup. 

In this case, based on the period variable, there was three visits maximum. The time variable, originally in days, says that there was 13 years of follow-up.


---
## Number of participants recruited into Framingham

```yaml
type: "FullSlide"
key: "8155410b68"
```

`@part1`
```{r}
framingham %>% 
    select(followup_visit_number = period) %>% 
    filter(followup_visit_number == 1) %>% 
    summarise(number_participants = n())
```
{{1}}

```{r}
# A tibble: 1 x 1
  number_participants
                <int>
1                4434
```
{{2}}


`@script`
Next, let's see how many participants were in the first visit. We select only the period and filter for the first visit, summarizing for the total number using n. 

We see that more than forty-four thousand participants were recruited.


---
## "Untidy" variable names in Framingham

```yaml
type: "FullSlide"
key: "fd098b73b9"
```

`@part1`
```{r}
names(framingham)
```
{{1}}

```
 [1] "randid"   "sex"      "totchol"  "age"      "sysbp"   
 [6] "diabp"    "cursmoke" "cigpday"  "bmi"      "diabetes"
[11] "bpmeds"   "heartrte" "glucose"  "educ"     "prevchd" 
[16] "prevap"   "prevmi"   "prevstrk" "prevhyp"  "time"    
[21] "period"   "hdlc"     "ldlc"     "death"    "angina"  
[26] "hospmi"   "mi_fchd"  "anychd"   "stroke"   "cvd"     
[31] "hyperten" "timeap"   "timemi"   "timemifc" "timechd" 
[36] "timestrk" "timecvd"  "timedth"  "timehyp" 
```
{{1}}


`@script`
There are many things that aren't clean or obvious from this dataset. For instance, when we look at the variable names, they don't clearly communicate their meaning. We'll need to tidy the data up as we explore it. We'll likely find more things to tidy in the process.


---
## Lesson summary

```yaml
type: "FullSlide"
key: "75da8bcc42"
```

`@part1`
- Design types {{1}}
    - Prospective: No disease, data collected as time passes
    - Retrospective: Disease at start, data obtained from past records
- Variables of interest {{2}}
    - Outcome: The disease 
    - Exposure/predictor: Factor that may influence the outcome
- Framingham: {{3}}
    - 3 visits, > 13 years follow up
    - ~ 4400 participants


`@script`
In summary, we compared the prospective and retrospective designs in terms of the difference in when the disease occurs, defined the outcome and exposure or predictor, and took a brief look at more details of the Framingham study.


---
## Let's practice and explore the dataset!

```yaml
type: "FinalSlide"
key: "ddbf9a5e1a"
```

`@script`
Now, let's get to exploring the data!

