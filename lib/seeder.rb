
module Seeder

  def create_customers
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
    c3.location = Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
    c3.confirm
    c3.save
  end

  def create_developers
    d1 = User.new
    d1.email = Faker::Internet.email
    pass = Faker::Internet.password
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
    d2.email = Faker::Internet.email
    pass = Faker::Internet.password
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
  end

  def purge
    # Clear Table Data
    User.delete_all
    Project.delete_all
    ProjectCustomer.delete_all
    Note.delete_all
    Discussion.delete_all
  end

end