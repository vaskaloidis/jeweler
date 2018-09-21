require 'application_system_test_case'

class TasksTest < ApplicationSystemTestCase
  setup do
    @owner = create(:user)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, owner: @owner)
    @task = @project.tasks.first
    login_as(@owner, scope: :user)
  end

  test 'creating a Task' do
    visit project_url(@project)
    click_on 'Create task'
    fill_in 'task[description]', with: 'new-task-desc'
    fill_in 'task[rate]', with: 13
    fill_in 'task[planned_hours]', with: 14
    fill_in 'task[hours]', with: 15
    click_on 'create_task_btn'
    assert_text 'Task was successfully created'
    task = Task.last
    assert_equal 'new-task-desc', task.description
    assert_equal 13, task.rate
    assert_equal 14, task.planned_hours
    assert_equal 15, task.hours
    refute task.complete
  end

  test 'complete a task' do
    visit('/')
    page.should have_content('ms6')
  end

  test 'complete a task' do
    sprint = @project.current_sprint
    task = Task.create(sprint: sprint, description: 'task description', rate: 25, planned_hours: 10, hours: 15, created_by: @owner, complete: false)
    visit project_url(@project)
    click_on(id: "task_row_#{task.id}")
    click_on("current_task_btn_#{task.id}")
    task.reload
    assert task.complete
  end

  test 'view a Task' do
    skip 'not done'
    visit project_url(@project)
    click_on 'View Task'

    click_on 'Back'
  end

  test 'updating a Task' do
    task = @projects.tasks.first
    skip 'not done'
    visit task_url(task)
    click_on 'Edit', match: :first

    click_on 'Update Task'

    assert_text 'Task was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Task' do
    task = @project.tasks.first
    skip 'not done'
    visit task_url(task)
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end
    assert_text 'Task was successfully destroyed'
  end
end
