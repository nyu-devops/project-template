# project-template

This is a skeleton you can use to start your projects

## Overview

This project template contains starter code for your class project. The `/service` folder contains your `models.py` file for your model and a `service.py` file for your service. The `/tests` folder has test case starter code for testing the model and the service separately. All you need to do is add your functionality. You can use the [lab-flask-rest](https://github.com/nyu-devops/lab-flask-rest)
for code examples.

## Setup

You should clone this repository and and the copy and paste the starter code into your project repo folder on your local computer. Be careful not to copy over your own README.md file so be selective in what you copy.

There are two hidden files that you will need to copy manually if you use the Finder to copy files from this folder into your repo folder. They are:

```bash
    cp .coveragerc ../<your_repo_folder>/
    cp .gitignore  ../<your_repo_folder>/
```

## Contents

The project contains the following:

```text
.coveragerc         - settings file for code coverage options
.gitignore          - this will ignore vagrant and other metadata files
dot-env-example     - copy to .env to use environment variables
requirements.txt    - list if Python libraries required by your code
config.py           - configuration parameters

service/            - service python package
├── __init__.py     - package initializer
├── models.py       - module with business models
└── service.py      - module with service routes

tests/              - test cases package
├── __init__.py     - package initializer
├── test_models.py  - test suite for busines models
└── test_service.py - test suite for service routes

Vagrantfile         - Sample Vagrant file that installs Python 3 and PostgreSQL
```

This repository is part of the NYU class **CSCI-GA.2810-001: DevOps and Agile Methodologies** taught by John Rofrano, Adjunct Instructor, NYU Curant Institute, Graduate Division, Computer Science.
