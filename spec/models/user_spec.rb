require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique email" do
    create(:user, email: "test@gmail.com")
    user2 = build(:user, email: "test@gmail.com")
    expect(user2).to_not be_valid
  end

  it "is not valid without a password" do
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end
end
