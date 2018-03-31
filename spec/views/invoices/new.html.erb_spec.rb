require 'rails_helper'

RSpec.describe "invoices/new", type: :view do
  before(:each) do
    assign(:invoice, Invoice.new(
      :sprint_ => 1,
      :payment_due => false,
      :description => "MyText",
      :belongs_to => ""
    ))
  end

  it "renders new invoice form" do
    render

    assert_select "form[action=?][method=?]", invoices_path, "post" do

      assert_select "input[name=?]", "invoice[sprint_]"

      assert_select "input[name=?]", "invoice[payment_due]"

      assert_select "textarea[name=?]", "invoice[description]"

      assert_select "input[name=?]", "invoice[belongs_to]"
    end
  end
end
