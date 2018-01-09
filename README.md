# Analyzing Cohort Data in R by Luke Johnston

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

Write full descriptions of a couple of significant exercises to show how far learners are likely to get.

### Title of Exercise

> **Solution**
>
> Include sample code.

### Other exercises

- Exercise title 1
  - Point-form description of exercise
  - Two or three bullets is enough

- Exercise title 2
  - Another point-form description
  - Again, two or three bullets is enough

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

- `path/to/dataset-1`: data set 1
- `path/to/dataset-2`: data set 2

## Step 5: Course overview

**Course Description**

One-paragraph description of the course.

**Learning Objectives**

- Objective 1
- Objective 2
- Objective 3

**Prerequisites**

- Prerequisite 1
- Prerequisite 2

[course-specs]: https://github.com/datacamp/example-course-specs
[profile-site]: https://github.com/datacamp/learner-profiles
