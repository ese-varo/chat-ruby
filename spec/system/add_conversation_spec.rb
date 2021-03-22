require "rails_helper"

RSpec.describe "A conversation" do
  let(:user) { create(:user) }
  let(:conversation) { build(:conversation) }
  before(:each) do
    visit(sign_in_path)
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    click_on("Log in")
  end

  let!(:second_user) { create(:user) }
  let!(:third_user) { create(:user) }

  it "can be started correctly" do
    click_on("New chat")
    expect(page).to have_selector("p", text: "Who do you want to chat with?")
    fill_in("Title", with: conversation.name)
    fill_in("Description", with: conversation.description)
    fill_in("Emoji", with: conversation.emoji)
    check(second_user.username)
    check(third_user.username)
    click_on("Save")
    expect(page).to have_selector("h3", text: conversation.name)
  end

  it "can be started correctly with many users" do
    forth_user = create(:user)
    fifth_user = create(:user)
    click_on("New chat")
    expect(page).to have_selector("p", text: "Who do you want to chat with?")
    fill_in("Title", with: conversation.name)
    fill_in("Description", with: conversation.description)
    fill_in("Emoji", with: conversation.emoji)
    check(second_user.username)
    check(third_user.username)
    check(forth_user.username)
    check(fifth_user.username)
    click_on("Save")
    expect(page).to have_selector("h3", text: conversation.name)
    expect(page).to have_selector(".participants", text: /.../)
  end

  it "with invalid title can't be created" do
    click_on("New chat")
    fill_in("conversation_name", with: nil)
    click_on("Save")
    expect(page).to have_selector("li", text: "Name can't be blank")
  end

  it "with invalid description can't be created" do
    click_on("New chat")
    fill_in("Description", with: nil)
    click_on("Save")
    expect(page).to have_selector("li", text: "Description can't be blank")
  end

  it "with invalid emoji can't be created" do
    click_on("New chat")
    fill_in("Emoji", with: nil)
    click_on("Save")
    expect(page).to have_selector("li",
      text: "Emoji should look like an emoji text input, e.g. :an_emoji:")
  end

  it "with unknown emoji gets a default assigned" do
    click_on("New chat")
    expect(page).to have_selector("p", text: "Who do you want to chat with?")
    fill_in("Title", with: conversation.name)
    fill_in("Description", with: conversation.description)
    fill_in("Emoji", with: ":#{Faker::Lorem.word}:")
    check(second_user.username)
    check(third_user.username)
    click_on("Save")
    expect(page).to have_selector(".alert-warning",
      text: "You provided an invalid emoji! A default one (❤) has been setted")
  end
end
