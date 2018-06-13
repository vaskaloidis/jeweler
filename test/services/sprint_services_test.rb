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
    sprint = create(:sprint_with_reported_hours, payment_due: false)
    service_object = RequestSprintPayment.call(sprint, @customer)
    sprint = service_object.result
    assert service_object.errors.empty?
    assert sprint.payment_due
  end

  test 'no reported hours prevented sprint payment request' do
    sign_in @customer
    sprint = create(:sprint, payment_due: false)
    service_object = RequestSprintPayment.call(sprint, @customer)
    sprint = service_object.result
    assert_equal 1, sprint.errors.count
    assert service_object.errors.must_include 'You must report hours to request payment'
    refute sprint.payment_due
  end

end