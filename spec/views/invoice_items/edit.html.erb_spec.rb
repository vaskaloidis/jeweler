require 'rails_helper'

RSpec.describe "invoice_items/edit", type: :view do
  before(:each) do
    @invoice_item = assign(:invoice_item, InvoiceItem.create!(
      :description => "MyText",
      :hours => "9.99",
      :rate => "9.99",
      :item_type => "MyString",
      :complete => false,
      :belongs_to => ""
    ))
  end

  it "renders the edit invoice_item form" do
    render

    assert_select "form[action=?][method=?]", invoice_item_path(@invoice_item), "post" do

      assert_select "textarea[name=?]", "invoice_item[description]"

      assert_select "input[name=?]", "invoice_item[hours]"

      assert_select "input[name=?]", "invoice_item[rate]"

      assert_select "input[name=?]", "invoice_item[item_type]"

      assert_select "input[name=?]", "invoice_item[complete]"

      assert_select "input[name=?]", "invoice_item[belongs_to]"
    end
  end
end
