require 'test_helper'

class RequestSprintPaymentTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project, :seed_tasks_notes, :seed_project_users)
    @owner = @project.owner
    @customer = @project.customers.first
  end

  test 'payment request' do
    sign_in @customer
    sprint = create(:sprint_with_reported_hours, payment_due: false)
    service_object = RequestSprintPayment.call(sprint, @customer)
    sprint = service_object.result
    assert service_object.errors.empty?
    assert sprint.payment_due
  end

  test 'payment already requested error' do
    sign_in @customer
    sprint = create(:sprint_with_reported_hours, payment_due: true)
    service = RequestSprintPayment.call(sprint, @customer)
    assert_equal 1, service.errors.count
    assert_includes service.errors, 'Payment already Requested.'
    assert service.payment_due
  end

  test 'no hours reported error' do
    sign_in @owner
    sprint = create(:sprint, payment_due: false)
    assert_equal 0, sprint.hours
    service = RequestSprintPayment.call(sprint, @owner)
    puts service.inspect
    sprint = service.result
    assert_equal 1, sprint.errors.count
    assert_includes service.errors, 'You must report hours to request payment'
    refute sprint.payment_due
  end

end