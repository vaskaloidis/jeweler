require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [
      Payment.create!(
        :payment_type => 2,
        :payment_identifier => "Payment Identifier",
        :payment_note => "Payment Note",
        :ammount => "9.99",
        :belongs_to => "",
        :belongs_to => ""
      ),
      Payment.create!(
        :payment_type => 2,
        :payment_identifier => "Payment Identifier",
        :payment_note => "Payment Note",
        :ammount => "9.99",
        :belongs_to => "",
        :belongs_to => ""
      )
    ])
  end

  it "renders a list of payments" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Payment Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Payment Note".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
