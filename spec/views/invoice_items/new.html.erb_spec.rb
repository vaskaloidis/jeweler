require 'rails_helper'

RSpec.describe "invoice_items/new", type: :view do
  before(:each) do
    assign(:invoice_item, InvoiceItem.new(
      :description => "MyText",
      :hours => "9.99",
      :rate => "9.99",
      :item_type => "MyString",
      :complete => false,
      :belongs_to => ""
    ))
  end

  it "renders new invoice_item form" do
    render

    assert_select "form[action=?][method=?]", invoice_items_path, "post" do

      assert_select "textarea[name=?]", "invoice_item[description]"

      assert_select "input[name=?]", "invoice_item[hours]"

      assert_select "input[name=?]", "invoice_item[rate]"

      assert_select "input[name=?]", "invoice_item[item_type]"

      assert_select "input[name=?]", "invoice_item[complete]"

      assert_select "input[name=?]", "invoice_item[belongs_to]"
    end
  end
end
