require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @owner = create(:user)
    @project = create(:project, :seed_tasks_notes, :seed_customer, owner: @owner)
    @task = @project.tasks.first
    login_as(@owner, scope: :user)
  end

  test "creating a Task" do
    visit project_url(@project)
    click_on "New Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "view a Task" do
    skip 'not done'
    visit project_url(@project)
    click_on "View Task"

    click_on "Back"
  end

  test "updating a Task" do
    task = @projects.tasks.first
    skip 'not done'
    visit task_url(task)
    click_on "Edit", match: :first

    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "destroying a Task" do
    task = @project.tasks.first
    skip 'not done'
    visit task_url(task)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end
    assert_text "Task was successfully destroyed"
  end
end
