require 'test_helper'

class RequestSprintPaymentTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @owner = create(:user)
    @customer = create(:user)
    @project = create(:project, owner: @owner)
    @project.add_customer(@customer)
  end

  test 'payment request succeeds' do
    sign_in @owner
    sprint = @project.current_sprint
    sprint.update(payment_due: false)
    create_list(:task, 5, sprint: sprint, created_by: @owner, hours: 4)
    service = RequestSprintPayment.call(sprint, @customer)
    assert service.errors.empty?
    assert service.result.payment_due
  end

  test 'payment already requested error' do
    sign_in @owner
    sprint = @project.current_sprint
    sprint.update(payment_due: true)
    create_list(:task, 5, sprint: sprint, created_by: @owner, hours: 4)
    service = RequestSprintPayment.call(sprint, @owner)
    assert_equal 1, service.errors.count
    assert_includes service.errors, 'Payment already Requested.'
    assert service.result.payment_due
  end

  test 'no hours reported error' do
    sign_in @owner
    sprint = @project.current_sprint
    sprint.update(payment_due: false)
    create_list(:task, 5, sprint: sprint, created_by: @owner, hours: 0, planned_hours: 2)
    assert_equal 0, sprint.hours
    service = RequestSprintPayment.call(sprint, @owner)
    assert_equal 1, service.errors.count
    assert_includes service.errors, 'You must report hours to request payment.'
    refute service.result.payment_due
  end

end