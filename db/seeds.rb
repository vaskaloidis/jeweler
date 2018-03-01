# Seeds
require 'faker'

# Clear Table Data
User.delete_all
Project.delete_all
ProjectCustomer.delete_all

# Seed Tables

# My User
u = User.new
u.email = 'vas.kaloidis@gmail.com'
u.password = 'password123'
u.password_confirmation = 'password123'
u.first_name = "Vas"
u.last_name = "Kaloidis"
u.website_url = 'http://vkaloidis.herokuapp.com'
u.bio = 'A Java and Ruby on Rails developer, trying to rule the world.'
u.tagline = 'Ruby on Rails Developer'
u.location = 'Woodbury, CT'
puts u.confirm
u.save

# 3 Generated Customers
c1 = User.new
c1.email = 'v.askaloidis@gmail.com'
pass = Faker::Internet.password
c1.password = pass
c1.password_confirmation = pass
c1.first_name = Faker::Name.first_name
c1.last_name = Faker::Name.last_name
c1.website_url = Faker::Internet.url
c1.tagline = 'A Robot User'
c1.bio = Faker::ChuckNorris.fact
c1.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
puts c1.confirm
c1.save

c2 = User.new
c2.email = 'kaloidisv@gmail.com'
pass = Faker::Internet.password
c2.password = pass
c2.password_confirmation = pass
c2.first_name = Faker::Name.first_name
c2.last_name = Faker::Name.last_name
c2.website_url = Faker::Internet.url
c2.tagline = 'Some User Tagline'
c2.bio = Faker::ChuckNorris.fact
c2.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
puts c2.confirm
c2.save

c3 = User.new
c3.email = 'v.a.skaloidis@gmail.com'
pass = Faker::Internet.password
c3.password = pass
c3.password_confirmation = pass
c3.first_name = Faker::Name.first_name
c3.last_name = Faker::Name.last_name
c3.website_url = Faker::Internet.url
c3.tagline = 'I am Awesome'
c3.bio = Faker::ChuckNorris.fact
c3.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
puts c3.confirm
c3.save

# Owner Project
p = Project.new
p.name = 'Blue Helmet Software Website'
p.owner = u
p.language = 'Ruby on Rails'
p.demo_url = 'http://bluehelmet.herokuapp.com'
p.prod_url = 'http://bluehelmet.herokuapp.com'
p.github_url = 'https://github.com/vaskaloidis/jewlercrm'
p.description = 'A website for the Blue Helmet Software Company, written in Ruby on Rails, hosted on Heroku'
p.save

# Project Customers
pc = ProjectCustomer.new
pc.user = c1
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

# Customer Projects
p = Project.new
p.name = Faker::Company.buzzword
p.language = Faker::ProgrammingLanguage.name
p.demo_url = Faker::Internet.url
p.prod_url = Faker::Internet.url
p.github_url = Faker::Internet.url('github.com')
p.github_secondary_url = Faker::Internet.url('github.com')
p.description = Faker::Company.catch_phrase
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
p.github_url = Faker::Internet.url('github.com')
p.github_secondary_url = Faker::Internet.url('github.com')
p.description = Faker::Company.catch_phrase
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
p.github_url = Faker::Internet.url('github.com')
p.github_secondary_url = Faker::Internet.url('github.com')
p.description = Faker::Company.catch_phrase
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