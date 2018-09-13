require 'test_helper'

class ProjectCustomerTest < ActiveSupport::TestCase
  should belong_to(:project)
  should belong_to(:user)
end