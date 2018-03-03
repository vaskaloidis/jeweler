require 'rails_helper'

RSpec.describe "project_customers/show", type: :view do
  before(:each) do
    @project_customer = assign(:project_customer, ProjectCustomer.create!(
      :project => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
