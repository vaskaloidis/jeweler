require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    @user = User.create(
        :email => "vas.kaloidis@gmail.com",
        :password => "password"
    )
    assign(:project, Project.new(
      :name => "MyString",
      :language => "MyString",
      :sprint_total => 1,
      :sprint_current => 1,
      :description => "MyText",
      :github_url => "MyString",
      :github_secondary_url => "MyString",
      :readme_file => "MyString",
      :readme_remote => false,
      :stage_website_url => "MyString",
      :demo_url => "MyString",
      :prod_url => "MyString",
      :complete => false,
      :stage_travis_api_url => "MyString",
      :stage_travis_api_token => "MyString",
      :prod_travis_api_token => "MyString",
      :prod_travis_api_url => "MyString",
      :coveralls_api_url => "MyString",
      :owner => @user
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input[name=?]", "project[name]"

      assert_select "input[name=?]", "project[language]"

      assert_select "input[name=?]", "project[sprint_total]"

      assert_select "input[name=?]", "project[sprint_current]"

      assert_select "textarea[name=?]", "project[description]"

      assert_select "input[name=?]", "project[github_url]"

      assert_select "input[name=?]", "project[github_secondary_url]"

      assert_select "input[name=?]", "project[readme_file]"

      assert_select "input[name=?]", "project[readme_remote]"

      assert_select "input[name=?]", "project[stage_website_url]"

      assert_select "input[name=?]", "project[demo_url]"

      assert_select "input[name=?]", "project[prod_url]"

      assert_select "input[name=?]", "project[complete]"

      assert_select "input[name=?]", "project[stage_travis_api_url]"

      assert_select "input[name=?]", "project[stage_travis_api_token]"

      assert_select "input[name=?]", "project[prod_travis_api_token]"

      assert_select "input[name=?]", "project[prod_travis_api_url]"

      assert_select "input[name=?]", "project[coveralls_api_url]"

      assert_select "input[name=?]", "project[customers_id]"
    end
  end
end
