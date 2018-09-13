require 'test_helper'

class ProjectDeveloperTest < ActiveSupport::TestCase
  should belong_to(:project)
  should belong_to(:user)
end
