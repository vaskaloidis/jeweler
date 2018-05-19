# Jewler Programmer CRM

Jeweler is an AGILE invoicing and CRM SAAS, designed specifically for Programmers. 

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
* In Jewler Stakeholders can view the contents of Git Commits, GitHub Issues, GitHub Activity

## Developers

```bash 
rake db:setup
``` 

### Prequisets

* Ruby 2.5.0
* Rails 5.1.4 is installed properly
* Bundler version 1.16.1
* Postgres (PostgreSQL) 10.3
* Puma
* Check `Gemfile` for all software and Gem versions

### Setup

Set the values in `/config/database.yml` to the Postgres database credentials (username password, db server) - my credentials are usernamme & password: `postgres and postgres` and database server URL: `localhost`

```bash
git clone git@github.com:vaskaloidis/jewlercrm.git
cd jewlercrm
bundle install

rails db:setup
```