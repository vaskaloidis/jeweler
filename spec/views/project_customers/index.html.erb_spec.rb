require 'rails_helper'

RSpec.describe "project_customers/index", type: :view do
  before(:each) do
    assign(:project_customers, [
      ProjectCustomer.create!(
        :project => nil,
        :user => nil
      ),
      ProjectCustomer.create!(
        :project => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of project_customers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
