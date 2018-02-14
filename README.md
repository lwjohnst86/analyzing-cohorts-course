# Analyzing Cohort Data in R by Luke Johnston
(Part 1? There is a lot to analyzing cohorts, this is the basic level...)

## Course development resources

* Course admin page: https://www.datacamp.com/teach/repositories/2079
* Authoring documentation: https://authoring.datacamp.com

*Please read the [example course specs][course-specs] and complete these steps
in the `README.md` file in your course repository. If you need assistance,
please speak with your Curriculum Lead.*

## Step 1: Brainstorming

1. What problem(s) will students learn how to solve?
    - Primary problems:
        - identifying the type of analysis to use for the specific type of cohort data
        - how to appropriately and meaningfully interpret and present these results
    - Secondary problems:
        - how to check that data fits your assumptions about it (assertr maybe?
        exploratory data analysis?)
        - how to plot results from regression models (pointrange)
2. What techniques or concepts will students learn?
    - regression to specific data (logistic for disease states, mixed effects?,
    cox models, survival)
    - how to plot cox models (kaplan-meier)
    - how to display results in tabular format (use rmarkdown? other packages to
    convert to table)
    - how to transform data and backtransform to calculate meaningful and
    understandable results
    - understanding the importanace of visualization to convey meaning to
    reader/consumer of your results
    - how to choose the appropriate visual/plot for the analysis
    - when to use visuals (preferable) and when to use text/tables
    - emphasize estimation and confidence (uncertainty) interval over
    significance testing
    - prospective vs retrospective (and the types of analyses you can do)
    - cohort study designs
    - understanding difference between incidence and prevalence of disease, and
    their calculation
3. What technologies, packages, or functions will students use?
    - regression (linear, logistic, cox, mixed effect?)
    - packages: ggplot, lme4?
    - statistics: glm, binomial, gaussian, poisson, cox models, survival
4. What terms or jargon will you define?
    - prospective/retrospective
    - panel study, longitudinal study
    - incidence, prevalence
    - odds ratio, relative risk, hazard ratio
5. What analogies or heuristics will you use?
    - ?
6. What mistakes or misconceptions do you expect?
    - misinterpreting results (this is common even by scientists)
    - not catching data error issues
    - presenting regression results as tables (a common practice in epidemiology
    unfortunately)
    - too much emphasis on p-values rather than estimation and uncertainty
    - not understanding probability/p-values
7. What datasets will you use?
    - this I need to look into (since cohort datasets are not commonly openly published).
        - possibles:
            - https://cancergenome.nih.gov/
            - https://cran.r-project.org/web/packages/survminer/vignettes/Informative_Survival_Plots.html
            - https://archive.ics.uci.edu/ml/datasets/Heart+Disease
            - https://archive.ics.uci.edu/ml/datasets/Diabetes+130-US+hospitals+for+years+1999-2008
            - https://archive.ics.uci.edu/ml/datasets/Diabetes
            - https://archive.ics.uci.edu/ml/datasets/Cervical+cancer+%28Risk+Factors%29
    - Likely use Cervical Cancer dataset
        - https://archive.ics.uci.edu/ml/datasets/Cervical+cancer+%28Risk+Factors%29
        
<!--
Resources or other courses from DataCamp to refer to:
    - Correlation and Regression
    - Multiple and Logistic Regression
    - Statistical Modeling in R
-->

## Step 2: Who is this course for?

Link to [student profiles][profile-site]. This course will be useful to two
learners, and possibly a third (dependent on field of study):

* Catalina: She will likely already know most of the basic statistical
techniques in the course. However, this course may give her material on creating
her own course, as this course will present various types of cohort study designs
and how to interpret the results from the statistical analyses (in the cohort
context). This will be useful to her medical students, who rely on this type of
data to make medical decisions that could save people's lives.
* Jasmine: The material in this course will teach her some fundamentals on how to
apply statistical techniques using code. If she teaches health insurance policy 
research at her alma mater, knowing the specifics of analyzing cohort datasets
would help make her students better with creating/analyzing/studying health
insurance policies.
* Mohan (or maybe another biomedical graduate student?): He will likely not be
interested in the statistical portion of this course, though he may find the 
sections with the code to analyze and interpret the cohort data useful. If he was
in any biomedical or health sciences graduate programs, he would find this course
very useful.

## Step 3: What will learners do along the way?

### Risk of developing a disease from exposures, over time 

*(an "end" goal exercise)*

(This could the final exercise. Q: How many lines of code is suitable for final
exercise?)

You are given a cohort dataset with information on disease and multiple
exposures, measured multiple times over many years (need to find dataset
suitable for this):

```
Participant,Time,DiseaseState,Exposure1,Exposure2,Exposure3,Covar1,Covar2
1,1, ...
1,2, ...
1,3, ...
2,1, ...
2,2, ...
....
```

What is the risk of disease of developing the disease for participants with 
higher values of Exposure1-3? When adjusted for covar1 and 2? Plot the results
of the models.

(Comments: This can be spread over 2 exercises. Likely step by step build up of
pieces.)

> **Solution** (not tested)
>
> ```{r}
> # Model
> model <- dataset %>% 
> gather(Exposure, ExpValue, Exp1:Exp3) %>% 
> nest(-Exposure) %>% 
> mutate(model = map_df(data, ~lmer(DiseaseState ~ ExpValue*Time + (1|Participant), data = .x)) %>% tidy()
> )
> # plot
> model %>% 
> ggplot() +
> geom_pointrange(aes(x = estimate, xmin = conf.low, xmax = conf.high)) +
> facet_grid(~ Exposure)
> ```

### Time to event analysis

*(an "end" goal exercise)*

(Cox model, still need to fill this out)

> **Solution**
>
> Include sample code.

### Other exercises

- Running multiple models 
    - Several possible routes here, either for several outcomes with several
    exposures or for grouping variables ("stratified analysis", e.g. on
    male/female).
    - Could be several exercise types: Fill in the blanks, "faded" example (?)
    - Potential example code:
    ```
    library(tidyverse)
    library(broom)
    dataset %>% 
        select(variables_of_interest) %>% 
        nest(-grouping_variable) %>% 
        mutate(model = map_df(data, ~ glm(outcome ~ exposure + covariates, data = .,
        family = binomial)))
    ```

- Transformations and interpretation
    - A continuous exposure variable was log transformed before running a 
    logistic regression. Here's the (toy) code:
    ```
    dataset %>% 
    mutate(logExposure = log(Exposure)) %>% 
    map_df(~glm(Disease ~ logExposure + covariate1, data = .x) %>% tidy(conf.int = TRUE))
    ```
    - An interpretation is given, but the interpretation of results assumes the
    unit of the exposure is before log transform, which is inaccurate.
    - Could be two exercises, one coded, another MCQ asking interpretation, and
    another exercise with correct one. Or could be "This is the code and
    interpretation. There is something wrong. Fix the code to get the correct
    interpretation."

- Manually calculate odds ratio, then through logistic regression
    - Calculate OR, then do it in logistic regression that has been adjusted.
    - Do two exercises. Code to get result, than MCQ to do interpretation, such as
    "which description is the correct interpretation?"

- Display the results of a regression analysis
    - Will need to filter the model results first, select the relevant variables,
    and graph the appropriate estimates.

## Step 4: How are the concepts connected?

- Chapter 1
  - Lesson 1.1
  - Lesson 1.2
  - Lesson 1.3
- Chapter 2
  - Lesson 2.1
  - Lesson 2.2
  - Lesson 2.3

The datasets are:

- `framingham`: (need to generate the file) Framingham Heart Study.
- `promise`: (need to confirm and add) PROMISE dataset.
- `diet`: Diet and CHD (from Epi package)
- `nickel` (with `ewrates`): From Epi (smelting workers, lung cancer) (not sure...)

## Step 5: Course overview

**Course Description**

Cohorts are a powerful scientific study design that allows researchers to
discover factors that can increase the risk of disease in a population.

There are many ways to analyze cohort studies, with many different research
questions that can be addressed. For this course, we will focus on the main
purpose of using cohorts: to study how disease states occur in a population.

**Learning Objectives**

- identifying the type of analysis to use for the specific type of cohort data
- how to appropriately and meaningfully interpret and present these results
- how to check that data fits your assumptions about it (assertr maybe?
exploratory data analysis?)
- how to plot results from regression models (pointrange)

**Prerequisites**

- Correlation and Regression
- Multiple and Logistic Regression
- Statistical Modeling in R
- dplyr?
- purrr?
- data visualization?

[course-specs]: https://github.com/datacamp/example-course-specs
[profile-site]: https://github.com/datacamp/learner-profiles
