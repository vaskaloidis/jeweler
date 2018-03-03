require 'rails_helper'

RSpec.describe "discussions/edit", type: :view do
  before(:each) do
    @discussion = assign(:discussion, Discussion.create!(
      :note => nil,
      :user => nil,
      :content => "MyText"
    ))
  end

  it "renders the edit discussion form" do
    render

    assert_select "form[action=?][method=?]", discussion_path(@discussion), "post" do

      assert_select "input[name=?]", "discussion[note_id]"

      assert_select "input[name=?]", "discussion[user_id]"

      assert_select "textarea[name=?]", "discussion[content]"
    end
  end
end
