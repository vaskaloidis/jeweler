require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @note = create(:note)
    @project = @note.project
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
    assert_difference('Note.count') do
      post notes_url, params: { note: {  } }, xhr: true
    end
    assert_response :success
    new_note = Note.last
  end

  test "should get edit" do
    get edit_note_url(@note), xhr: true
    assert_response :success
  end

  test "should update note" do
    patch note_url(@note), params: { note: {  } }, xhr: true
    assert_response :success
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete note_url(@note), xhr: true
    end
    assert_response :success
  end
end
