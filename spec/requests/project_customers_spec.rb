require 'rails_helper'

RSpec.describe "ProjectCustomers", type: :request do
  describe "GET /project_customers" do
    it "works! (now write some real specs)" do
      get project_customers_path
      expect(response).to have_http_status(200)
    end
  end
end
