require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @user = User.create(
        :email => "vas.kaloidis@gmail.com",
        :password => "password"
    )
    @project = assign(:project, Project.create!(
      :name => "Name",
      :language => "Language",
      :sprint_total => 2,
      :sprint_current => 3,
      :description => "MyText",
      :github_url => "Github Url",
      :github_secondary_url => "Github Secondary Url",
      :readme_file => "Readme File",
      :readme_remote => false,
      :stage_website_url => "Stage Website Url",
      :demo_url => "Demo Url",
      :prod_url => "Prod Url",
      :complete => false,
      :stage_travis_api_url => "Stage Travis Api Url",
      :stage_travis_api_token => "Stage Travis Api Token",
      :prod_travis_api_token => "Prod Travis Api Token",
      :prod_travis_api_url => "Prod Travis Api Url",
      :coveralls_api_url => "Coveralls Api Url",
      :owner => @user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Language/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Github Url/)
    expect(rendered).to match(/Github Secondary Url/)
    expect(rendered).to match(/Readme File/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Stage Website Url/)
    expect(rendered).to match(/Demo Url/)
    expect(rendered).to match(/Prod Url/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Stage Travis Api Url/)
    expect(rendered).to match(/Stage Travis Api Token/)
    expect(rendered).to match(/Prod Travis Api Token/)
    expect(rendered).to match(/Prod Travis Api Url/)
    expect(rendered).to match(/Coveralls Api Url/)
    expect(rendered).to match(//)
  end
end
