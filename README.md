# LFM - RoutePlanner
To provide students with actionable insights based on their syllabus, helping them identify gaps and access relevant resources.

## Process:


1. Upload Syllabus: Students upload their syllabus document.
2. AI Analysis: ChatGPT analyzes the syllabus to identify key concepts, prerequisites, and potential areas of improvement.
3. Resource Suggestion:
    - NTHU On-Campus Courses: Matches are suggested for official NTHU courses.
    - YouTube Lectures: For topics not covered by official courses, suggest high-quality online resources (e.g., GitHub tutorials).


## ERD



## Setup
* Create a personal YouTube Token with ```public_repo``` scope
* Copy ```config/secrets_example.yml``` to ```config/secrets.yml``` and update token 
* Ensure correct version of Ruby install (see ```.ruby-version``` for ```rbenv```)
* run bundle install

## Running Tests
To run the test: 
```
rake spec
```







