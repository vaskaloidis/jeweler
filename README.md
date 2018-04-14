# Jewler Programmer CRM

Jeweler is an AGILE invoicing and CRM SAAS, designed specifically for Programmers. 

### Summary

Using Jeweler, devs can make sure to get paid on-time. It allows devs to always keep their customers / stake-holders informed on what the dev is working on, and **allows the dev to keep his head in the code and spend as little time as possible keeping the customer informed on development work and project completion**

Designed around the AGILE methodology, development tasks are broken down into Sprints. Developers can plan project cost by creating tasks for each sprint, and assigning an hour estimate to each task. Devs can specify which task they are currently working on; **automatically all Git commit messages will be assigned to the current-task whenever they are committed / pushed.**

Using GitHub hooks, programmers can add actionable tasks to commit messages. So by including a Jeweler Action in the Git Commit Message (IE: @jeweler#current_task#hours#15#complete will mark the current-task as complete, and post 15 hours as the time it took to complete the task. Jeweler will then automatically set the next un-completed task as the current-task.) This allows the programmer to spend as much time as possible coding.


### Jeweler Features:
* Accept Customer Payments
* Create Development Cycles (Sprints)
* Set a Current-Task - Mark Tasks Complete, Open and Close Sprints, etc...
* Git Commit Messages Are Assigned To Current-Task
* Jeweler Action Commands in Git Commit Messages Allow Devs To Keep Their Head In the Code And Always Keeping Stakeholders In The Loop
* Generate Invoices And Send To Customer + Request Payment
* Build Project Development Plans (Sprints, Sprint Tasks, Task Hour Estimates and Sprint Planning)
* Allow Stakeholders to Keep Track of GitHub and Heroku Activity in Jeweler
* In Jewler Stakeholders can view the contents of Git Commits, GitHub Issues, GitHub Activity
* Connect Heroku CI and Customers Can View If Builds Succesfull or Failed, and why
* Customers can dynamically view current README.md contents in Jeweler

## Developers

To get Jeweler up and running, simply pull it down from GitHub, install the Gems using Bundler, and run `rake db:setup` to seed the database and setup the Development environment.

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