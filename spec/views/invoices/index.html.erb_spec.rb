require 'rails_helper'

RSpec.describe "invoices/index", type: :view do
  before(:each) do
    assign(:invoices, [
      Invoice.create!(
        :sprint_ => 2,
        :payment_due => false,
        :description => "MyText",
        :belongs_to => ""
      ),
      Invoice.create!(
        :sprint_ => 2,
        :payment_due => false,
        :description => "MyText",
        :belongs_to => ""
      )
    ])
  end

  it "renders a list of invoices" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
