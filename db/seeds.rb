# Seeds
require 'faker'
require 'screencap'

# Clear Table Data
User.delete_all
Project.delete_all
ProjectCustomer.delete_all
Note.delete_all
Discussion.delete_all

# Seed Tables

# My User
  u = User.new
  u.email = 'vas.kaloidis@gmail.com'
  u.password = 'password123'
  u.password_confirmation = 'password123'
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
  u.company = 'Red Tail Software'
  c1.first_name = Faker::Name.first_name
  c1.last_name = Faker::Name.last_name
  c1.website_url = Faker::Internet.url
  c1.tagline = 'A Robot User'
  c1.bio = Faker::ChuckNorris.fact
  c1.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
  puts c1.confirm
  c1.save

  c2 = User.new
  c2.email = Faker::Internet.email
  pass = Faker::Internet.password
  c2.password = pass
  c2.password_confirmation = pass
  u.company = 'Jim Bob Software Corporation'
  c2.first_name = Faker::Name.first_name
  c2.last_name = Faker::Name.last_name
  c2.website_url = Faker::Internet.url
  c2.tagline = 'Some User Tagline'
  c2.bio = Faker::ChuckNorris.fact
  c2.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
  puts c2.confirm
  c2.save

  c3 = User.new
  c3.email = Faker::Internet.email
  pass = Faker::Internet.password
  c3.password = pass
  c3.password_confirmation = pass
  u.company = 'Google Software Company'
  c3.first_name = Faker::Name.first_name
  c3.last_name = Faker::Name.last_name
  c3.website_url = Faker::Internet.url
  c3.tagline = 'I am Awesome'
  c3.bio = Faker::ChuckNorris.fact
  c3.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
  puts c3.confirm
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
  p.phase_total = 8
  p.phase_current = 1
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

# Project Notes + Discussion
  n = Note.new
  n.note_type = 'project_update'
  n.content = 'Project development is going well. The User interface portion of development has been started
  because the backend was completed successfully.'
  n.author = c1
  n.project = p
  n.save
  Discussion.create(note: n, user: c1, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: c2, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: u, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: c1, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: c2, content: Faker::ChuckNorris.fact)

  n = Note.new
  n.note_type = 'note'
  n.content = 'We had an issues with the frontend UI so we are switching Javascript frameworks to VueJS'
  n.author = c1
  n.project = p
  n.save
  Discussion.create(note: n, user: c3, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: u, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: c1, content: Faker::ChuckNorris.fact)

  n = Note.new
  n.note_type = 'demo'
  n.content = 'http://bluehelmet.herokuapp.com'
  n.author = c1
  n.project = p
  # f = Screencap::Fetcher.new(n.content)
  # screenshot = f.fetch
  # u.image = screenshot
  # u.image = Rails.root.join('app/assets/images/seeds/screenshot.png').open
  n.save
  Discussion.create(note: n, user: c2, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: u, content: Faker::ChuckNorris.fact)
  Discussion.create(note: n, user: c1, content: Faker::ChuckNorris.fact)

# Customer Projects
p = Project.new
p.name = Faker::Company.buzzword
p.language = Faker::ProgrammingLanguage.name
p.demo_url = Faker::Internet.url
p.prod_url = Faker::Internet.url
p.github_url = Faker::Internet.url('github.com')
p.github_secondary_url = Faker::Internet.url('github.com')
p.description = Faker::Company.catch_phrase
p.phase_total = 8
p.phase_current = 1
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
p.phase_total = 8
p.phase_current = 1
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
p.phase_total = 8
p.phase_current = 1
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