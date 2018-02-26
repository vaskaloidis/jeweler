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
u.save


# Customers

c1 = User.new
c1.email = Faker::Internet.email
pass = Faker::Internet.password
c1.password = pass
c1.password_confirmation = pass


c2 = User.new
c2.email = Faker::Internet.email
pass = Faker::Internet.password
c2.password = pass
c2.password_confirmation = pass

c3 = User.new
c3.email = Faker::Internet.email
pass = Faker::Internet.password
c3.password = pass
c3.password_confirmation = pass


# Project
p = Project.new
p.name = Faker::Company.buzzword
p.owner = u
p.save

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

p.owner = u
p.save

# Test
puts c1.customer_projects.first.name
puts p.customers.first.email