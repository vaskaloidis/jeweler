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

  # TODO: Finish this, its not working at all. The controller is the part not working it looks like. Refactor controller with a service object and TDD the service object to verify it works in a seperate test in services
  test "should create note" do
    project = create(:project, :seed_tasks_notes, :seed_project_users)
    new_note = attributes_for(:note, project: project, sprint: project.current_sprint)
    new_note[:project_id] = project.id
    assert_difference('Note.count') do
      post notes_url, params: {note: new_note}, xhr: true
    end
    assert_response :success
    last_note = Note.last
    Rails.logger.info("new note content: " + new_note[:content])
    Rails.logger.info("last note content: " + last_note.content)
    assert_equal new_note[:content], last_note.content
    assert_equal new_note[:note_type], last_note.note_type
    # TODO: Finish this assert_equal new_note[:project_id], last_note.project.id
    # TODO: Finish this assertion assert_equal @user.id, last_note.author.id
  end

  test "should get edit" do
    get edit_note_url(@note), xhr: true
    assert_response :success
  end

  test "should update note" do
    patch note_url(@note), params: {note: {content: 'note-content-update'}}, xhr: true
    assert_response :success
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete note_url(@note), xhr: true
    end
    assert_response :success
  end
end
