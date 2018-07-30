# (Introduction to?) Analyzing Cohort Data in R by Luke Johnston

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
    - regression to specific data (logistic for disease states, mixed effects?)
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
    - Framingham Heart Study

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

- See exercises found in chapters [1](chapter1.Rmd), [2](chapter2.Rmd),
[3](chapter3.Rmd), and [4](chapter4.Rmd).

## Step 4: How are the concepts connected?

- Chapter 1: Introduction to cohorts and types of research questions
    - Lesson 1: Introduction to cohort designs
    - Lesson 2: Introduction to the datasets and exploring them
    - Lesson 3: Scientific questions that can be asked of cohort data
- Chapter 2: Data exploring, wrangling, and formatting
    - Lesson 1: Pre-wrangling exploration
    - Lesson 2: Tidy cohort data and wrangling into analyzable form.
    - Lesson 3: Transforming and modifying variables (maybe into two lessons?)
- Chapter 3: Running the statistical techniques
    - Lesson 1: Common statistical techniques used for analyzing cohorts
    - Lesson 2: Adjustment, confounding, and modelling.
    - Lesson 3: Interaction testing and sensitivity analyses
    - Lesson 4: Extracting relevant data from results and post-modelling-wrangling {{wording needs changes}}
- Chapter 4: Presentation of results from cohort studies
    - Lesson 1: Language and information to use when communicating the findings
    - Lesson 2: Back transforming results for easier interpretation
    - Lesson 3: Communicating your results through graphs
    - Lesson 4: Using tables to convey your findings

The dataset is:

- `framingham`: Framingham Heart Study.

## Step 5: Course overview

### Course Description

Cohort studies are a powerful study design that allows researchers to
better understand how to reduce, manage, or prevent disease in a population.
The findings from cohorts are critical to creating effective public health
interventions. Because peoples' lives and health are directly impacted
by the findings from cohort studies, there is immense pressure to ensure that the
analysis done correctly and appropriately and that the presentation of results is as
meaningful and as simple as possible. The difficulty in the analysis also comes 
from the wide range in study designs, data collection and type, and research
questions. In this course, we'll be covering how and what to analytically ask of
cohort data, what are special considerations for data processing, which
statistical techniques to choose, and how to present the results for effective
communication to public health professionals.

### Learning Objectives

#### Overall

- Learn how cohort data looks like and what questions to ask of it
- Learn what to look for when exploring and pre-processing the data before the
main analysis that may be more specific to cohort datasets
- Learn how to think about and approach processing, analyzing, and presenting
results from cohort studies in a way that is meaningful and interpretable to end
users, the clinicians and the public health professionals

#### Chapter 1

- Know that analyzing cohorts is just as much about the process/workflow as it
is about the specific tools/statistics to use.
- Recognize the type of cohort design from the data
- Know which research questions can and cannot be asked of the given data
- Have a general understand of which statistical tests to use for which data and
that the test will dictate how the data should look.
- Know where to look and what resources to use if you can't find the statistical
or analytical techniques needed to analyze the data.

#### Chapter 2

- How to get data into form for quick exploration
- How to wrangle the data to get into a form to use for the analysis/statistic
- Know the various tools to transform the data and when is more appropriate to
use them
    - Know to be very careful of ever converting continuous into discrete
    - Know when and why to transform variables (good reasons and bad)
    - Reducing number of categories in categorical variable
- Dealing with outliers (or not)

#### Chapter 3

- Learn to run some common statistic techniques on different datasets and research
questions
- Learn how to extract the relevant results from these stats methods
- Understand why its important to not use or even look at p-values in the output
- Know how to understand and interpret the results (we'll get to knowing what
exactly is most useful to present and show for higher impact)
- Importance of examining multiple levels of adjustment (unadjusted, minimally,
fully), and how this can inform what is going on in the relationship.
- Knowing how to choose/decide on what variables to adjust for

#### Chapter 4

- Give careful thought into how to best show results in a understandable and
impactful way for public health professionals and clinicians.
- Emphasize figures over tables, but know when to use either.
- Be cautious in interpreting "non-significant" findings, since they could also
have meaningful clinical implications.
- Use cautious language when presenting results
    - Especially with "causal" language
- Discuss STROBE guidelines in context of longitudinal study.

### Prerequisites

- [Intro to tidyverse](https://github.com/datacamp/courses-intro-to-tidyverse)
- [Descriptive Epidemiology in R](https://github.com/datacamp/courses-descriptive-epidemiology-in-r)
- [Correlation and Regression](https://github.com/datacamp/courses-intro-stats-correlation-regression)


[course-specs]: https://github.com/datacamp/example-course-specs
[profile-site]: https://github.com/datacamp/learner-profiles
