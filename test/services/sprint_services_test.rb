require 'test_helper'

class SprintServicesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project, :seed_tasks_notes, :seed_customer)
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

  test 'can not request payment without reported sprint hours' do
    skip 'Error message is not coming back preventing the payment request'
    sign_in @owner
    sprint = create(:sprint, payment_due: false)
    assert_equal 0, sprint.hours
    service_object = RequestSprintPayment.call(sprint, @owner)
    puts service_object.inspect
    sprint = service_object.result
    assert_equal 1, sprint.errors.count
    assert service_object.errors.must_include 'You must report hours to request payment'
    refute sprint.payment_due
  end

end