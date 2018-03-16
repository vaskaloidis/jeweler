require 'rails_helper'

RSpec.describe "InvoiceItems", type: :request do
  describe "GET /invoice_items" do
    it "works! (now write some real specs)" do
      get invoice_items_path
      expect(response).to have_http_status(200)
    end
  end
end
