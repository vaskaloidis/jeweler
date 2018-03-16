require 'rails_helper'

RSpec.describe "invoice_items/show", type: :view do
  before(:each) do
    @invoice_item = assign(:invoice_item, InvoiceItem.create!(
      :description => "MyText",
      :hours => "9.99",
      :rate => "9.99",
      :item_type => "Item Type",
      :complete => false,
      :belongs_to => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Item Type/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
