# Seeds
require 'faker'

# Clear Table Data
# User.delete_all
# Project.delete_all
# ProjectCustomer.delete_all
# Note.delete_all
# Discussion.delete_all

# Seed Tables

# My User
u = User.new
u.email = 'vas.kaloidis@gmail.com'
u.password = 'password'
u.password_confirmation = 'password'
u.company = 'Blue Helmet Software'
u.first_name = 'Vas'
u.last_name = 'Kaloidis'
u.website_url = 'http://vkaloidis.herokuapp.com'
u.bio = 'A Java and Ruby on Rails developer, trying to rule the world.'
u.tagline = 'Ruby on Rails Developer'
u.location = 'Woodbury, CT'
u.image = Rails.root.join('app/assets/images/seeds/athf.jpg').open
u.confirm
u.save

# 3 Generated Customers
c1 = User.new
c1.email = Faker::Internet.email
pass = Faker::Internet.password
c1.password = pass
c1.password_confirmation = pass
c1.company = 'Red Tail Software'
c1.first_name = Faker::Name.first_name
c1.last_name = Faker::Name.last_name
c1.website_url = Faker::Internet.url
c1.tagline = 'A Robot User'
c1.bio = Faker::ChuckNorris.fact
c1.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c1.confirm
c1.save

c2 = User.new
c2.email = Faker::Internet.email
pass = Faker::Internet.password
c2.password = pass
c2.password_confirmation = pass
c2.company = 'Jim Bob Software Corporation'
c2.first_name = Faker::Name.first_name
c2.last_name = Faker::Name.last_name
c2.website_url = Faker::Internet.url
c2.tagline = 'Some User Tagline'
c2.bio = Faker::ChuckNorris.fact
c2.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c2.confirm
c2.save

c3 = User.new
c3.email = Faker::Internet.email
pass = Faker::Internet.password
c3.password = pass
c3.password_confirmation = pass
c3.company = 'Google Software Company'
c3.first_name = Faker::Name.first_name
c3.last_name = Faker::Name.last_name
c3.website_url = Faker::Internet.url
c3.tagline = 'I am Awesome'
c3.bio = Faker::ChuckNorris.fact
c3.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
c3.confirm
c3.save

# pi = ProductImage.create!(:product => product)
# pi.image.store!(File.open(File.join(Rails.root, 'test.jpg')))
# product.product_images << pi
# product.save!

# Owner Project
p = Project.new
p.name = 'Blue Helmet Software Website'
p.owner = u
p.language = 'Ruby on Rails'
p.demo_url = 'http://bluehelmet.herokuapp.com'
p.prod_url = 'http://bluehelmet.herokuapp.com'
p.github_url = 'https://github.com/vaskaloidis/jewlercrm'
p.description = 'A website for the Blue Helmet Software Company, written in Ruby on Rails, hosted on Heroku'
p.sprint_total = 8
p.sprint_current = 1
p.image = Rails.root.join('app/assets/images/seeds/bluehelmet.png').open
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

# Invoice
sprint1 = Invoice.create(sprint: 1, description: 'Get the template purchased. Plan the web application design. Build the relational database.
    Setup the code plumbing.', project: p)
InvoiceItem.create(position: 0, invoice: sprint1, description: 'Research and Purchase the template.', planned_hours: rand(0..8), hours: 8, rate: 35)
InvoiceItem.create(position: 1, invoice: sprint1, description: 'Design the web application.', planned_hours: rand(0..4), hours: 4, rate: 35)
InvoiceItem.create(position: 2, invoice: sprint1, description: 'Design the relational database.', planned_hours: rand(0..5), hours: 5, rate: 35)
InvoiceItem.create(position: 3, invoice: sprint1, description: 'Setup the plumbing for the rails project, after generating it.', planned_hours: rand(0..10), hours: 10, rate: 35)

sprint2 = Invoice.create(sprint: 2, description: 'Build the SASS system, and implement the Bootstrap template into Rails. Design the Gem configuration and
  build Gemfile..', project: p)
InvoiceItem.create(position: 0, invoice: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
InvoiceItem.create(position: 1, invoice: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
InvoiceItem.create(position: 2, invoice: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
InvoiceItem.create(position: 3, invoice: sprint2, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)

sprint3 = Invoice.create(sprint: 3, description: 'Scaffold the database and build the relational data structure.', project: p)
InvoiceItem.create(position: 0, invoice: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
InvoiceItem.create(position: 1, invoice: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
InvoiceItem.create(position: 2, invoice: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)
InvoiceItem.create(position: 3, invoice: sprint3, description: Faker::ChuckNorris.fact, planned_hours: rand(0..10), rate: 35)

sprint4 = Invoice.create(sprint: 4, description: 'Implement the design into the project scaffold system.', project: p)
InvoiceItem.create(position: 0, invoice: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)
InvoiceItem.create(position: 1, invoice: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)
InvoiceItem.create(position: 2, invoice: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)
InvoiceItem.create(position: 3, invoice: sprint4, description: Faker::ChuckNorris.fact, planned_hours: rand(0..5), rate: 35)

# Customer Projects
p = Project.new
p.name = Faker::Company.buzzword
p.language = Faker::ProgrammingLanguage.name
p.demo_url = Faker::Internet.url
p.prod_url = Faker::Internet.url
p.github_url = Faker::Internet.url('github.com')
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
p.github_url = Faker::Internet.url('github.com')
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
p.github_url = Faker::Internet.url('github.com')
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