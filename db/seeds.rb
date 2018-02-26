# Seeds

require 'faker'

# Clear Table Data
User.delete_all
Project.delete_all
ProjectCustomer.delete_all

# Seed Tables
u = User.new
u.email = 'vas.kaloidis@gmail.com'
u.password = 'password123'
u.password_confirmation = 'password123'
u.first_name = Faker::Name.first_name
u.last_name = Faker::Name.last_name
u.website_url = Faker::Internet.url
u.bio = Faker::ChuckNorris.fact
u.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
u.save

# 3 Customers
c1 = User.new
c1.email = Faker::Internet.email
pass = Faker::Internet.password
c1.password = pass
c1.password_confirmation = pass
c1.first_name = Faker::Name.first_name
c1.last_name = Faker::Name.last_name
c1.website_url = Faker::Internet.url
c1.bio = Faker::ChuckNorris.fact
c1.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c1.save

c2 = User.new
c2.email = Faker::Internet.email
pass = Faker::Internet.password
c2.password = pass
c2.password_confirmation = pass
c2.first_name = Faker::Name.first_name
c2.last_name = Faker::Name.last_name
c2.website_url = Faker::Internet.url
c2.bio = Faker::ChuckNorris.fact
c2.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c2.save

c3 = User.new
c3.email = Faker::Internet.email
pass = Faker::Internet.password
c3.password = pass
c3.password_confirmation = pass
c3.first_name = Faker::Name.first_name
c3.last_name = Faker::Name.last_name
c3.website_url = Faker::Internet.url
c3.bio = Faker::ChuckNorris.fact
c3.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c3.save

# Project
p = Project.new
p.name = 'Blue Helmet Software Website'
p.owner = u
p.language = 'Ruby on Rails'
p.demo_url = 'http://bluehelmet.herokuapp.com'
p.prod_url = 'http://bluehelmet.herokuapp.com'
p.github_url = 'https://github.com/vaskaloidis/jewlercrm'
p.description = 'A website for the Blue Helmet Software Company, written in Ruby on Rails, hosted on Heroku'
p.owner = u
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

# Test
puts 'Test Customer 1 Project Name - '
puts c1.customer_projects.first.name
puts 'Test Project Customer 1 name - '
puts p.customers.first.email