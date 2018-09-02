# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @owner = create(:user)
    @project = create(:project, :seed_tasks_notes, :seed_customer, owner: @owner)
    login_as(@owner, scope: :user)
  end

  test 'visiting the index' do
    visit projects_url
    assert_selector 'h1', text: @owner.full_name
  end

  test 'creating a Project' do
    visit projects_url
    click_on 'New Project'
    assert_difference('Project.count') do
      fill_in 'Name', 'new-project-name'
      fill_in 'Github url', 'http://github.com/vaskaloidis/jeweler-test-project'
      fill_in 'Project Description', 'new-project-desc'
      fill_in 'Sprint current', '2'
      fill_in 'Sprint total', '12'
      click_on 'Submit'
    end
    assert_redirected_to projects_url
    latest = Project.last
    assert_equal 'new-project-name', latest.name
    click_on 'Back'
  end

  test 'updating a Project' do
    visit project_url(@project)
    click_on 'Edit', match: :first

    click_on 'Update Project'

    assert_text 'Project was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Project' do
    visit projects_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Project was successfully destroyed'
  end
end
