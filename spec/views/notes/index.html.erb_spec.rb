require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        :content => "Content",
        :note_type => 2,
        :content => "MyText",
        :git_commit_id => "Git Commit",
        :project => nil,
        :discussion => nil,
        :author => nil
      ),
      Note.create!(
        :content => "Content",
        :note_type => 2,
        :content => "MyText",
        :git_commit_id => "Git Commit",
        :project => nil,
        :discussion => nil,
        :author => nil
      )
    ])
  end

  it "renders a list of notes" do
    render
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Git Commit".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
