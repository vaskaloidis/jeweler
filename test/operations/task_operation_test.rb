require 'test_helper'
require_relative '../../app/concepts/task/operation/create'

class TaskOperationTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @owner = create :user
    sign_in @owner
    @project = create(:project, owner: @owner)
  end

# fails validations
  it 'tests validations' do
    result = Task::Create.call(params: {task: {}}, current_user: @owner)
    expect(result.failure?).to eq true
    errors = result['result.errors']
    errors.wont_be_empty
    # expect(errors).to include(:description)
    # expect(errors).to include(:rate)
    # expect(errors[:description]).to eq'cannot be empty'
    # expect(errors[:rate]).to eq'cannot be empty'

    # curent_user is missing
    result = Task::Create.(params: {task: {description: 'task-description-set', rate: 25}}, current_user: nil)
    expect(result.failure?).to eq true
    errors = result['result.errors']
    errors.wont_be_empty
    # expect(errors).to include(:user)
    # expect(errors[:user]).to eq'must be assigned'
  end
#:validation end

#:create
  it 'successfully create' do

    result = Task::Create.call(params: {task: {description: 'task-description-set',
                                               rate: 25.0,
                                               hours: 15.0,
                                               planned_hours: 12.0,
                                               complete: true}},
                               current_user: @owner)

    expect(result.success?).to eq true
    task = result['model']
    task.description.must_equal 'task-description-set'
    task.rate.must_equal 25.0
    task.planned_hours.must_equal 12.0
    task.hours.must_equal 15.0
    task.complete.must_equal true
    task.user_id.must_equal @owner.id
    Task.all.size.must_equal 1
    # one notification has been sent to user
  end


end