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
title: Instructor


`@script`
Before getting more into the Framingham dataset, we're going to quickly cover more differences between the two cohort types. Since Framingham is a prospective cohort, I'll highlight why a prospective cohort was chosen over a retrospective one for this course.


---
## Comparisons between the two designs

```yaml
type: "FullSlide"
key: "583fae4d2d"
```

`@part1`
![Retrospective vs prospective cohorts. Euser et al, doi:10.1159/000235241](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/a183894d11c7317da3f4831b9e6b75cb4929942d/pro-vs-retro.png)


`@script`
We briefly covered the main difference between the two cohort types, specifically when the outcome occurs relative to the study start. In retrospective cohorts, people have the disease at the study start and their data is collected from past records. This is very common when data is collected frequently or consistently, such as in hospitals, and is easily available. In prospective cohorts, people don't have a disease at the study start. They are usually followed over time until the study end. Over time, more data is collected. Both designs have their strengths and weaknesses. If you have easy access to data already collected by a hospital or by the government, retrospective cohort designs are a very powerful scientific tool. But, there are many strengths to prospective cohort designs. They give stronger scientific evidence to research questions, because people are recruited without the disease. The Framingham dataset was chosen for this reason.


---
## How a prospective cohort looks over time

```yaml
type: "FullImageSlide"
key: "b7cc4ddc54"
```

`@part1`
![Visual example of a prospective cohort](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/5008b35c45932322dbbdc87458ff4456ecaafedc/plot-prospective-outcome.png)


`@script`
Here we see a typical prospective cohort. Each line is a hypothetical participant. At the study start, no one has a disease. As time passes, some people get the disease and others don't. When the study ends or at the time of analysis, there are a group of people who have the disease, the orange lines, and usually a lot more who don't, the blue lines. There is also data collected at several time points over the study period. So now, you can compare how these two groups of people are different. What factors distinguish those with and without the disease? That is what we try to answer when we analyze the data.


---
## Main variables of interest

```yaml
type: "FullSlide"
key: "278d9126a9"
```

`@part1`
- *Outcome*: 
    - Disease or health state (e.g. cancer)
    - Commonly shown as the $y$ in regression analysis

- *Exposure/predictor*: 
    - Variable hypothesized to relate to a disease (e.g. tobacco smoking)
    - Commonly shown as the $x$ in regression analysis


`@script`
In cohort studys, there are commonly two terms used, outcome and exposure or predictor. The term outcome is used to mean the disease and it is the y variable commonly seen in statistical notation. The term exposure or predictor represents the variables that relate to or potentially influence the outcome in some way. These are the variables that we think predict getting the disease, for example, cigarette smoke and lung cancer.


---
## The prospective Framingham cohort

```yaml
type: "TwoRows"
key: "88bd3012a7"
```

`@part1`
```{r}
library(dplyr)
framingham %>%
    select(followup_visit_number = period, days_of_followup = time)
    summarise(number_visits = max(followup_visit_number),
              number_years = round(max(days_of_followup) / 365, 1))

#> # A tibble: 1 x 2
#>   number_visits number_years
#>           <dbl>        <dbl>
#> 1             3         13.3
```


`@part2`
```{r}
framingham %>% 
    select(followup_visit_number = period) %>% 
    filter(followup_visit_number == 1) %>% 
    summarise(number_participants = n())

#> # A tibble: 1 x 1
#>   number_participants
#>                 <int>
#> 1                4434
```


`@script`
Let's look more at the data. Using dplyr, we can see the maximum number of visits participants came in for and how long they where followed for. Here, we see there were 3 visits, found by looking at the period variable, and >13 years of follow-up, found from the time variable, which was in days. Next, let's check how many participants came at the first visit. To only see baseline data, we filter by the first period. Here it shows there are >4400 participants, which is a pretty big sample.


---
## The prospective Framingham cohort

```yaml
type: "FullSlide"
key: "fd098b73b9"
```

`@part1`
```{r}
names(framingham)
```

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

```
> unique(framingham$educ)
[1]  4  2  1  3 NA
> unique(framingham$sex)
[1] 1 2
```


`@script`
Now, there are many things that aren't clean or obvious from this dataset. The variable names aren't clear while some values don't tell us their meaning. For instance, what does 2 mean for sex or education? Or, what does "timeap" mean? Before doing any analysis, we'll need to tidy it up. But first, we should explore the data to better understand it.


---
## Lesson summary

```yaml
type: "FullSlide"
key: "75da8bcc42"
```

`@part1`
- Design types
    - Prospective: No disease, data collected as time passes
    - Retrospective: Disease at start, data obtained from past records
- Variables of interest
    - Outcome: The disease 
    - Exposure/predictor: Factor that may influence the outcome
- Framingham:
    - 3 visits, >13 years follow up
    - ~4400 participants


`@script`
In summary, we compared the prospective and retrospective designs, the difference in when the disease occurs, the outcome and exposure or predictor, and a brief look at the Framingham study.


---
## Let's practice and explore the dataset!

```yaml
type: "FinalSlide"
key: "ddbf9a5e1a"
```

`@script`
Now, let's get to exploring the data!

