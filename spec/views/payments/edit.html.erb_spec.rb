require 'rails_helper'

RSpec.describe "payments/edit", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
      :payment_type => 1,
      :payment_identifier => "MyString",
      :payment_note => "MyString",
      :ammount => "9.99",
      :belongs_to => "",
      :belongs_to => ""
    ))
  end

  it "renders the edit payment form" do
    render

    assert_select "form[action=?][method=?]", payment_path(@payment), "post" do

      assert_select "input[name=?]", "payment[payment_type]"

      assert_select "input[name=?]", "payment[payment_identifier]"

      assert_select "input[name=?]", "payment[payment_note]"

      assert_select "input[name=?]", "payment[ammount]"

      assert_select "input[name=?]", "payment[belongs_to]"

      assert_select "input[name=?]", "payment[belongs_to]"
    end
  end
end
