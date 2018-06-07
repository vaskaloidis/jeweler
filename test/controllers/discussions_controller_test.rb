# frozen_string_literal: true

require 'test_helper'

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project)
    @note = create(:note)
    # TODO: Security Checks / Permissions Checks (Customer VS. Owner)
  end

  test 'should fetch a note discussions' do
    @user = @project.owner
    sign_in @user
    get fetch_discussion_url(@note), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'owner should create discussion message' do
    @user = @project.owner
    sign_in @user
    new_discussion = attributes_for(:discussion)
    new_discussion[:note_id] = @note.id
    assert_difference('Discussion.count') do
      post create_discussion_message_url, params: { content: 'new-owner-note-discussion', note_id: @note.id.to_s }, xhr: true
    end
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    discussion = Discussion.last
    assert_equal 'new-owner-note-discussion', discussion.content
    assert_equal @note.id, discussion.note.id
    assert_equal @user.id, discussion.user.id
  end

  test 'customer should create discussion message' do
    @user = @project.project_customers.first.user
    sign_in @user
    new_discussion = attributes_for(:discussion)
    new_discussion[:note_id] = @note.id
    assert_difference('Discussion.count') do
      post create_discussion_message_url, params: { content: 'new-customer-note-discussion', note_id: @note.id.to_s }, xhr: true
    end
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    discussion = Discussion.last
    assert_equal 'new-customer-note-discussion', discussion.content
    assert_equal @note.id, discussion.note.id
    assert_equal @user.id, discussion.user.id
  end
end
