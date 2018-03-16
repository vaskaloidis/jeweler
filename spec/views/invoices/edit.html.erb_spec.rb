require 'rails_helper'

RSpec.describe "invoices/edit", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
      :phase => 1,
      :payment_due => false,
      :description => "MyText",
      :belongs_to => ""
    ))
  end

  it "renders the edit invoice form" do
    render

    assert_select "form[action=?][method=?]", invoice_path(@invoice), "post" do

      assert_select "input[name=?]", "invoice[phase]"

      assert_select "input[name=?]", "invoice[payment_due]"

      assert_select "textarea[name=?]", "invoice[description]"

      assert_select "input[name=?]", "invoice[belongs_to]"
    end
  end
end
