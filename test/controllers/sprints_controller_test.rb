# frozen_string_literal: true

require 'test_helper'

class SprintsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @sprint = create(:sprint)
    @owner = @sprint.project.owner
    @customer = @sprint.project.customers.first
  end

  test 'should get index for owner and customer' do
    sign_in @owner
    get project_sprints_url(@sprint.project)
    assert_response :success
    sign_out @owner
    sign_in @customer
    get project_sprints_url(@sprint.project)
    assert_response :success
  end

  test 'should show sprint for owner and customer' do
    sign_in @owner
    get sprint_url(@sprint)
    assert_response :success
    sign_out @owner
    sign_in @customer
    get sprint_url(@sprint)
    assert_response :success
  end

  test 'should get edit' do
    sign_in @owner
    get edit_sprint_url(@sprint)
    assert_response :success
  end

  test 'should update sprint' do
    sign_in @owner
    base_sprint = create(:sprint, open: true, description: 'some-desc', payment_due: false)
    patch sprint_url(base_sprint), params: {
      sprint: {
        description: 'updated-sprint-desc',
        payment_due: true,
        open: false
      }
    }, xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    base_sprint.reload
    last_sprint = Sprint.last
    assert_equal 'updated-sprint-desc', last_sprint.description
    assert_equal true, last_sprint.payment_due
    assert_equal false, last_sprint.open
  end

  test 'edit sprint description' do
    sign_in @owner
    get edit_sprint_description_path(@sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'render sprint panel' do
    sign_in @owner
    get render_sprint_path(@sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'set current sprint' do
    sign_in @owner
    project = create(:project)
    next_sprint = project.get_sprint(project.sprint_total - 1)
    if next_sprint.current?
      next_sprint = project.get_sprint(project.sprint_total - 2)
    end
    get set_current_sprint_path(next_sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    next_sprint.reload
    assert next_sprint.current?
  end

  test 'request sprint payment' do
    sign_in @owner
    sprint = create(:sprint_with_reported_hours, payment_due: false)
    get request_payment_url(sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    sprint.reload
    assert sprint.payment_due
  end

  test 'cancel sprint payment request' do
    sign_in @owner
    sprint = create(:sprint, payment_due: true)
    get cancel_payment_request_url(sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    sprint.reload
    refute sprint.payment_due
  end

  test 'open sprint' do
    sign_in @owner
    sprint = create(:sprint, open: false)
    get open_sprint_path(sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    sprint.reload
    assert sprint.open
  end

  test 'close sprint' do
    sign_in @owner
    sprint = create(:sprint, open: true)
    get close_sprint_path(sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    sprint.reload
    refute sprint.open
  end
end
