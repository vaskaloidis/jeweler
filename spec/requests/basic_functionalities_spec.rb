require 'rails_helper'

RSpec.describe "Basic Functionality Test", type: :request do

  describe "GET Homepage" do
    it "Gets the homepage and verifies a 200 HTTP response" do
      get "/"
      expect(response).to have_http_status(200)
      # page.should have_content('A Warm Welcome!')
    end
  end

end
