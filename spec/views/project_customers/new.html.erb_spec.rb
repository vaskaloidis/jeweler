require 'rails_helper'

RSpec.describe "project_customers/new", type: :view do
  before(:each) do
    assign(:project_customer, ProjectCustomer.new(
      :project => nil,
      :user => nil
    ))
  end

  it "renders new project_customer form" do
    render

    assert_select "form[action=?][method=?]", project_customers_path, "post" do

      assert_select "input[name=?]", "project_customer[project_id]"

      assert_select "input[name=?]", "project_customer[user_id]"
    end
  end
end
