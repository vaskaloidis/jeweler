require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    @user = User.create(
        :email => "vas.kaloidis@gmail.com",
        :password => "password"
    )

    assign(:projects, [
      Project.create!(
        :name => "Name",
        :language => "Language",
        :phase_total => 2,
        :phase_current => 3,
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
      ),
      Project.create!(
        :name => "Name",
        :language => "Language",
        :phase_total => 2,
        :phase_current => 3,
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
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Github Url".to_s, :count => 2
    assert_select "tr>td", :text => "Github Secondary Url".to_s, :count => 2
    assert_select "tr>td", :text => "Readme File".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Stage Website Url".to_s, :count => 2
    assert_select "tr>td", :text => "Demo Url".to_s, :count => 2
    assert_select "tr>td", :text => "Prod Url".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Stage Travis Api Url".to_s, :count => 2
    assert_select "tr>td", :text => "Stage Travis Api Token".to_s, :count => 2
    assert_select "tr>td", :text => "Prod Travis Api Token".to_s, :count => 2
    assert_select "tr>td", :text => "Prod Travis Api Url".to_s, :count => 2
    assert_select "tr>td", :text => "Coveralls Api Url".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
