require 'rails_helper'

describe User do
  it "is valid with a username, email and password" do
    user = User.new(
      username: 'elmerotyler',
      email: 'elmerotyler@gmail.com',
      password: 'elmerotyler',
      password_confirmation: 'elmerotyler')
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(username: '')
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without a password confirmation" do
    user = User.new(password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    user = User.new(email: '')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      username: 'elmerobueno',
      email: 'elmerobueno@gmail.com',
      password: 'elmerobueno',
      password_confirmation: 'elmerobueno')
    user = User.new(
      username: 'elotro',
      email: 'elmerobueno@gmail.com',
      password: 'elmerobueno', password_confirmation: 'elmerobueno')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it "is invalid with a duplicate username" do
    User.create(
      username: 'elmerobueno',
      email: 'elmerobueno@gmail.com',
      password: 'elmerobueno',
      password_confirmation: 'elmerobueno')
    user = User.new(username: 'elmerobueno')
    user.valid?
    expect(user.errors[:username]).to include('has already been taken')
  end

  it "is invalid with a username greater than 3 or less than 100 chars" do
    user = User.new(
      username: 'elmerobueno',
      email: 'elmerobueno@gmail.com',
      password: 'elmerobueno',
      password_confirmation: 'elmerobueno')
    expect(user).to be_valid
  end

  it "is invalid with unmatching password" do
    user = User.new(
      username: 'elmerobueno',
      email: 'elmerobueno@gmail.com',
      password: 'elmerobueno',
      password_confirmation: 'elmerobuenote')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "is invalid with password less than 8 chars" do
    user = User.new(password: 'less', password_confirmation: 'less')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "returns a collection of conversations with other user" do
    fulano = User.create(
      username: 'fulano',
      email: 'fulano@gmail.com',
      password: 'elfulano',
      password_confirmation: 'elfulano')
    mangano = User.create(
      username: 'mangano',
      email: 'mangano@gmail.com',
      password: 'elmangano',
      password_confirmation: 'elmangano')
    first_conversation = fulano.conversations.create(
      name: 'A nice conversation',
      description: 'Lets have a nice conversation',
      emoji: ':rainbow:')
    second_conversation = fulano.conversations.create(
      name: 'Why rspec is a good option',
      description: 'Lets talk about using rspec with rails',
      emoji: ':dog_face:')
    first_conversation.users << mangano
    second_conversation.users << mangano
    expect(mangano.shared_conversations_with(fulano)).to eq [first_conversation, second_conversation]
  end

  it "returns a collection of users ordered by username" do
    zergio = User.create(
      username: 'zergio',
      email: 'zergio@gmail.com',
      password: 'elzergio',
      password_confirmation: 'elzergio')
    romario = User.create(
      username: 'romario',
      email: 'elromario@gmail.com',
      password: 'elromario',
      password_confirmation: 'elromario')
    juan = User.create(
      username: 'juan',
      email: 'juan@gmail.com',
      password: 'elesjuan',
      password_confirmation: 'elesjuan')

    expect(User.ordered).to eq [juan, romario, zergio]
  end
end
