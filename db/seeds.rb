# frozen_string_literal: true

# Seeds
require 'faker'
require '../app/helpers/projects_helper'
include ProjectsHelper

# Clear Table Data
User.delete_all
Project.delete_all
ProjectCustomer.delete_all
ProjectDeveloper.delete_all
Invitation.delete_all
Payment.delete_all
Note.delete_all
Discussion.delete_all
Task.delete_all
Sprint.delete_all

# My User
u = User.new
u.email = 'vas.kaloidis@gmail.com'
u.password = 'password'
u.password_confirmation = 'password'
u.company = 'Blue Helmet Software'
u.first_name = 'Vas'
u.last_name = 'Kaloidis'
u.website_url = 'http://vkaloidis.herokuapp.com'
u.tagline = 'Ruby on Rails Developer'
u.location = 'Woodbury, CT'
u.image = Rails.root.join('app/assets/images/seeds/athf.jpg').open
u.confirm
u.save

# 3 Generated Customers
c1 = User.new
c1.email = 'customer1@gmail.com'
pass = 'password'
c1.password = pass
c1.password_confirmation = pass
c1.company = 'Red Tail Software'
c1.first_name = Faker::Name.first_name
c1.last_name = Faker::Name.last_name
c1.website_url = Faker::Internet.url
c1.tagline = 'A Robot User'
c1.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c1.confirm
c1.save
c2 = User.new
c2.email = 'customer2@gmail.com'
pass = 'password'
c2.password = pass
c2.password_confirmation = pass
c2.company = 'Jim Bob Software Corporation'
c2.first_name = Faker::Name.first_name
c2.last_name = Faker::Name.last_name
c2.website_url = Faker::Internet.url
c2.tagline = 'Some User Tagline'
c2.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c2.confirm
c2.save
c3 = User.new
c3.email = 'customer3@gmail.com'
pass = 'password'
c3.password = pass
c3.password_confirmation = pass
c3.company = 'Google Software Company'
c3.first_name = Faker::Name.first_name
c3.last_name = Faker::Name.last_name
c3.website_url = Faker::Internet.url
c3.tagline = 'I am Awesome'
c3.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c3.confirm
c3.save

d1 = User.new
d1.email = 'developer1@gmail.com'
pass = 'password'
d1.password = pass
d1.password_confirmation = pass
d1.company = 'Red Tail Software'
d1.first_name = Faker::Name.first_name
d1.last_name = Faker::Name.last_name
d1.website_url = Faker::Internet.url
d1.tagline = 'A Robot User'
d1.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
d1.confirm
d1.save
d2 = User.new
d2.email = 'developer2@gmail.com'
pass = 'password'
d2.password = pass
d2.password_confirmation = pass
d2.company = 'Red Tail Software'
d2.first_name = Faker::Name.first_name
d2.last_name = Faker::Name.last_name
d2.website_url = Faker::Internet.url
d2.tagline = 'A Robot User'
d2.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
d2.confirm
d2.save

# Owner Project
p = Project.new
p.name = 'Blue Helmet Software Website'
p.owner = u
p.language = ProjectHelper.languages.index('rails')
p.demo_url = 'http://bluehelmet.herokuapp.com'
p.prod_url = 'http://bluehelmet.herokuapp.com'
p.description = 'A website for the Blue Helmet Software Company, written in Ruby on Rails, hosted on Heroku'
p.sprint_total = 8
p.sprint_current = 1
p.image = Rails.root.join('app/assets/images/seeds/bluehelmet.png').open
p.save

p.project_customers.create(user: c1)
p.project_customers.create(user: c2)
p.project_customers.create(user: c3)
p.project_developers.create(user: d1)
p.project_developers.create(user: d2)

sprint1 = p.get_sprint(1)
sprint1.update(description: 'Get the template purchased. Plan the web application design. Build the DB.')
sprint2 = p.get_sprint(2)
sprint2.update(description: 'Build the SASS system, and implement the Bootstrap template.')
sprint3 = p.get_sprint(3)
sprint3.update(description: 'Scaffold the database and build the relational data structure.')
sprint4 = p.get_sprint(4)
sprint4.update(description: 'Implement the design into the project scaffold system.')

# Task.create(created_by: u, sprint: sprint, description: 'desc', planned_hours: rand(0..8), hours: 8, rate: 35)

# Task.create(created_by: u, sprint: sprint1, description: Faker::ChuckNorris.fact, planned_hours: rand(0..8), hours: 8, rate: 35)

build_tasks = true
if build_tasks
  Task.create(created_by: u, sprint: sprint1, description: Faker::ChuckNorris.fact, planned_hours: rand(0..8), hours: 8, rate: 35)
  Task.create(created_by: u, sprint: sprint1, description: Faker::ChuckNorris.fact, planned_hours: rand(0..4), hours: 4, rate: 35)
  Task.create(created_by: d2, assigned_to: d1, sprint: sprint1, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), hours: 5, rate: 35)
  Task.create(created_by: d2, assigned_to: d1, sprint: sprint1, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), hours: 10, rate: 35)
  Task.create(created_by: d1, assigned_to: d2, sprint: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, assigned_to: d2, sprint: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, assigned_to: d2, sprint: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, assigned_to: d2, sprint: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, sprint: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, sprint: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, sprint: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, assigned_to: u, sprint: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
  Task.create(created_by: d1, sprint: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)
  Task.create(created_by: d1, assigned_to: d2, sprint: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)
  Task.create(created_by: d1, assigned_to: u, sprint: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)
  Task.create(created_by: d1, sprint: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)
end

# Customer Projects
p = Project.new
p.name = Faker::Company.buzzword
p.language = Faker::ProgrammingLanguage.name
p.demo_url = Faker::Internet.url
p.prod_url = Faker::Internet.url
p.description = Faker::Company.catch_phrase
p.sprint_total = 8
p.sprint_current = 1
p.owner = c1
p.save

pc = ProjectCustomer.new
pc.user = u
pc.project = p
pc.save
pc = ProjectCustomer.new
pc.user = c2
pc.project = p
pc.save
pc = ProjectCustomer.new
pc.user = c3
pc.project = p
pc.save

p = Project.new
p.name = Faker::Company.buzzword
p.language = Faker::ProgrammingLanguage.name
p.demo_url = Faker::Internet.url
p.prod_url = Faker::Internet.url
p.description = Faker::Company.catch_phrase
p.sprint_total = 8
p.sprint_current = 1
p.owner = c1
p.save

pc = ProjectCustomer.new
pc.user = u
pc.project = p
pc.save
pc = ProjectCustomer.new
pc.user = c2
pc.project = p
pc.save
pc = ProjectCustomer.new
pc.user = c3
pc.project = p
pc.save

p = Project.new
p.name = Faker::Company.buzzword
p.language = Faker::ProgrammingLanguage.name
p.demo_url = Faker::Internet.url
p.prod_url = Faker::Internet.url
p.description = Faker::Company.catch_phrase
p.sprint_total = 8
p.sprint_current = 1
p.owner = c2
p.save

pc = ProjectCustomer.new
pc.user = u
pc.project = p
pc.save
pc = ProjectCustomer.new
pc.user = c1
pc.project = p
pc.save
pc = ProjectCustomer.new
pc.user = c3
pc.project = p
pc.save

puts 'Jeweler Seeded Succesfully'
