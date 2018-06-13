<p align="center">
<a href="http://jeweler-staging.bluehelmet.software"><img width="400" src="https://raw.githubusercontent.com/vaskaloidis/jeweler/master/app/assets/images/jeweler-logo-full-alternate.png"></a>
</p>

[![CircleCI](https://circleci.com/gh/vaskaloidis/jeweler.svg?style=svg&circle-token=0695c448bed1c7ed2fc9e4d982aa38f0651ca0c4)](https://circleci.com/gh/vaskaloidis/jeweler)
[![Slack](https://img.shields.io/badge/discuss-Slack-brightgreen.svg)](https://bluehelmet.slack.com)
[![Coverage Status](https://coveralls.io/repos/github/vaskaloidis/jeweler/badge.svg?branch=master)](https://coveralls.io/github/vaskaloidis/jeweler?branch=master)

Jeweler is a project planning, invoicing and CRM SAAS, designed specifically for `programmers`, built around the Agile development methodology. 

- [http://jeweler-staging.bluehelmet.software](http://jeweler-staging.bluehelmet.software)
- [http://jeweler.bluehelmet.software](http://jeweler.bluehelmet.software)

### Summary

Using Jeweler, devs can make sure to get paid on-time. It allows devs to always keep their customers / stake-holders informed on what the dev is working on.
 
 **Jeweler allows the dev to keep his head in the code and spend as little time as possible keeping the customer informed on development work and project completion**

### Jeweler Features:
* Accept Customer Payments
* Build Project Development Plans (Sprints, Sprint Tasks, Task Hour Estimates and Sprint Planning)
* Set a Current-Task - Mark Tasks Complete, Open and Close Sprints, etc...
* Jeweler Commit Codes - Codes inside Git Commit messages that execute tasks in Jeweler, like updating a tasks hours, estimated hours, marking it as complete, assigning a git commit to that task, etc... Allow Devs To Keep Their Head In the Code And Always Keeping Stakeholders In The Loop
* Generate Invoices And Send To Customer + Request Payment
* Allow Stakeholders to Keep Track of GitHub and Heroku Activity in Jeweler
* In Jeweler Stakeholders can view the contents of Git Commits, GitHub Issues, GitHub Activity

## Developers

To setup the database schema and migrations run

```bash 
rake db:setup
``` 

Run all the tests

```bash
rake test
```
For verbose testing
(Fix for Minitest CLI Options bug for running `rake test -vb`)
```bash
rake test TESTOPTS='-vb'
```


### Required

* Ruby 2.5.1
* Ruby on Rails 5.2.0
* Bundler version 1.16.1
* Postgres (PostgreSQL) 10.3
* Puma 3.11
* Check `Gemfile` for all software and Gem versions

### Setup

Set the values in `/config/database.yml` to the Postgres database credentials (username password, db server) - my credentials are usernamme & password: `postgres and postgres` and database server URL: `localhost`

```bash
git clone git@github.com:vaskaloidis/jewelercrm.git
cd jewelercrm
bundle install

rails db:setup
```

## Usage

### Jeweler Commit Commands

Jeweler Commit Codes can be placed at the end of Git commit messages to execute various actions in Jeweler. Commit codes always start with
`#jeweler`

You can string them together like this:
`#jeweler#task4a#complete #jeweler#task4a#hours#5 #jeweler#task4a#estimate#3 #jeweler#task4b#current`
#### Tasks
Task commit codes start with the Task ID. Example: `#task4a`
```
  #jeweler#task4a
```
To complete a task:
```
  #jeweler#task4a#complete
```
To report hours for a task:
```
  #jeweler#task4a#hours#<hours>
  Example: #jeweler#task4a#hours#3
```
To report estimated task hours:
```
  #jeweler#task4a#estimate#<estimated-hours>
  Example: #jeweler#task4a#estimate#2
```
Set current task
```
  #jeweler#task4a#current
```
To complete, or incomplete a task
```
  #jeweler#task4a#complete
  #jeweler#task4a#incomplete
```

#### Sprint
Set current sprint
```
  #jeweler#sprint4#current
```
Open and close a sprint
```
  #jeweler#sprint4#open
  #jeweler#sprint4#close
```
Request payment for a sprint, or cancel a payment-request
```
  #jeweler#sprint4#request-payment
  #jeweler#sprint3#cancel-payment-request
```
Send invoice or estimate
```
  #jeweler#sprint4#send-invoice
  #jeweler#sprint4#send-estimate
```
#### Commit
To specify a different commit message to be displayed in the Jeweler note (rather than the commit message):
```
  #jeweler#commit#message#<your-message-here>
```
To hide the commit message entirely:
```
  #jeweler#commit#hide-message
```

## Misc.
### Heroku Memory Configs
Environment variables for Heroku memory settings; used for debugging memory issues / slow requests / slow system
```cofig
WEB_CONCURRENCY="1"
RAILS_MAX_THREADS="5"
RAILS_SERVE_STATIC_FILES="enabled"
RUBY_GC_HEAP_GROWTH_FACTOR="1.03"
LANG="en_US.UTF-8"
PORT="80"
RAILS_LOG_TO_STDOUT="enabled"
```