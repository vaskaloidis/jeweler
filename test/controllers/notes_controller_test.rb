require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @note = create(:note)
    @project = @note.project
    @user = @project.owner
    sign_in @user
  end

  test "should open new note modal" do
    get create_note_modal_url(@project), xhr: true
    assert_response :success
  end

  test "should get new" do
    get new_project_note_path(@project), xhr: true
    assert_response :success
  end

  test "should create note" do
    project = create(:project)
    new_note = attributes_for(:note, project: project)
    assert_difference('Note.count') do
      post notes_url, params: { note: new_note }, xhr: true
    end
    assert_response :success
    last_note = Note.last
    assert_equal new_note.content, last_note.content
    assert_equal new_note.note_type, last_note.note_type
    assert_equal new_note.project.id, last_note.project.id
    assert_equal @user.id, last_note.user.id
  end

  test "should get edit" do
    get edit_note_url(@note), xhr: true
    assert_response :success
  end

  test "should update note" do
    patch note_url(@note), params: { note: { content: 'note-content-update'  } }, xhr: true
    assert_response :success
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete note_url(@note), xhr: true
    end
    assert_response :success
  end
end
