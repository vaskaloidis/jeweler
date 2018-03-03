require 'rails_helper'

RSpec.describe "project_customers/edit", type: :view do
  before(:each) do
    @project_customer = assign(:project_customer, ProjectCustomer.create!(
      :project => nil,
      :user => nil
    ))
  end

  it "renders the edit project_customer form" do
    render

    assert_select "form[action=?][method=?]", project_customer_path(@project_customer), "post" do

      assert_select "input[name=?]", "project_customer[project_id]"

      assert_select "input[name=?]", "project_customer[user_id]"
    end
  end
end
