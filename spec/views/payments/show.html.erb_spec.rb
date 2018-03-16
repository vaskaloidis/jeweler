require 'rails_helper'

RSpec.describe "payments/show", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
      :payment_type => 2,
      :payment_identifier => "Payment Identifier",
      :payment_note => "Payment Note",
      :ammount => "9.99",
      :belongs_to => "",
      :belongs_to => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Payment Identifier/)
    expect(rendered).to match(/Payment Note/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
