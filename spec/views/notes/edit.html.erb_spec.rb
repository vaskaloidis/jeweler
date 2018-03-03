require 'rails_helper'

RSpec.describe "notes/edit", type: :view do
  before(:each) do
    @note = assign(:note, Note.create!(
      :content => "MyString",
      :note_type => 1,
      :content => "MyText",
      :git_commit_id => "MyString",
      :project => nil,
      :discussion => nil,
      :author => nil
    ))
  end

  it "renders the edit note form" do
    render

    assert_select "form[action=?][method=?]", note_path(@note), "post" do

      assert_select "input[name=?]", "note[content]"

      assert_select "input[name=?]", "note[note_type]"

      assert_select "textarea[name=?]", "note[content]"

      assert_select "input[name=?]", "note[git_commit_id]"

      assert_select "input[name=?]", "note[project_id]"

      assert_select "input[name=?]", "note[discussion_id]"

      assert_select "input[name=?]", "note[author_id]"
    end
  end
end
