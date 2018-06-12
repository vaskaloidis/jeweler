require 'test_helper'

class SprintServicesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project)
    @owner = @project.owner
    @customer = @project.customers.first
  end

  test 'customer request sprint payment service' do
    sign_in @customer
    sprint = create(:sprint, payment_due: false)
    service_object = RequestSprintPayment.call(sprint, @customer)
    sprint = service_object.result
    assert sprint.payment_due
  end

end