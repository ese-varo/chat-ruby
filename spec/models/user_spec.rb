require 'rails_helper'

describe User do
  it "is valid with a username, email and password" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a username" do
    user = build(:user, username: '')
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without a password confirmation" do
    user = build(:user, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    user = build(:user, email: '')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    create(:user, email: 'elfulano@example.com')
    user = build(:user, email: 'elfulano@example.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it "is invalid with a duplicate username" do
    create(:user, username: 'elfulano')
    user = build(:user, username: 'elfulano')
    user.valid?
    expect(user.errors[:username]).to include('has already been taken')
  end

  it "is invalid with a username greater than 3 or less than 100 chars" do
    expect(build(:user)).to be_valid
  end

  it "is invalid with unmatching password" do
    user = build(:user, password_confirmation: 'confirmation')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "is invalid with password less than 8 chars" do
    user = build(:user, password: 'less', password_confirmation: 'less')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "returns a collection of conversations with other user" do
    first_user = create(:user)
    second_user = create(:user)
    first_conversation = create(:conversation, users: [first_user, second_user])
    second_conversation = create(:conversation, users: [first_user, second_user])
    expect(first_user.shared_conversations_with(second_user))
      .to eq [first_conversation, second_conversation]
  end

  it "returns a collection of users ordered by username" do
    zergio = create(:user, username: 'zergio')
    romario = create(:user, username: 'romario')
    juan = create(:user, username: 'juan')
    expect(User.ordered).to eq [juan, romario, zergio]
  end
end
