require 'rails_helper'

RSpec.describe "invoice_items/index", type: :view do
  before(:each) do
    assign(:invoice_items, [
      InvoiceItem.create!(
        :description => "MyText",
        :hours => "9.99",
        :rate => "9.99",
        :item_type => "Item Type",
        :complete => false,
        :belongs_to => ""
      ),
      InvoiceItem.create!(
        :description => "MyText",
        :hours => "9.99",
        :rate => "9.99",
        :item_type => "Item Type",
        :complete => false,
        :belongs_to => ""
      )
    ])
  end

  it "renders a list of invoice_items" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Item Type".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
