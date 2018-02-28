require 'rails_helper'
require 'support/factory_bot'
require 'support/database_cleaner'

RSpec.describe Project, type: :model do
  before(:all) do
    @project1 = create(:project)
  end

  it "is valid with valid attributes" do
    expect(@project1).to be_valid
  end

  # it "has a unique github" do
  #   create(:project, github_url: "http://github.com/username/existing_project")
  #   expect {
  #     build(:project, github_url: "http://github.com/username/existing_project")
  #   }.to raise_error(RecordInvalid)
  # end
  #
  # it "Does not have a valid owner" do
  #   expect {
  #     build(:project, owner: nil)
  #   }.to raise_error(RecordInvalid)
  # end
  #
  # it "is not valid without a project name" do
  #   expect {
  #     build(:project, name: nil)
  #   }.to raise_error(RecordInvalid)
  # end

end
