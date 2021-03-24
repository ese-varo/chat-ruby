require "rails_helper"

RSpec.describe "A conversation" do
  let!(:user) { create(:user) }
  let!(:conversation) { create(:conversation, users: [user]) }
  before(:each) do
    visit(sign_in_path)
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    click_on("Log in")
  end

  it "has a user" do
    expect(conversation.users.first).to have_attributes(username: user.username)
  end

  it "can have messages" do
    conversation.messages << create_list(:message, 5, user: user)
    expect(conversation.messages.count).to be 5
  end

  it "is displayed correctly" do
    find("#btn-see-#{conversation.id}").click
    expect(page).to have_selector("h3", text: conversation.name)
  end

  describe "can be edited" do
    let!(:second_user) { create(:user) }
    before(:each) do
      visit(edit_conversation_path(conversation))
    end

    it "and with correct data is saved successfully" do
      second_conversation = build(:conversation)
      fill_in("Title", with: second_conversation.name)
      fill_in("Description", with: second_conversation.description)
      fill_in("Emoji", with: second_conversation.emoji)
      check(second_user.username)
      click_on("Save")
      expect(page).to have_selector("h3", text: second_conversation.name)
    end

    it "and correctly change its status to private" do
      choose("conversation_status_private")
      click_on("Save")
      expect(page).to have_selector("#status", text: "private")
    end

    it "and with invalid name is not saved" do
      fill_in("Title", with: nil)
      click_on("Save")
      expect(page).to have_selector("li", text: "Name can't be blank")
    end

    it "and with invalid Description is not saved" do
      fill_in("Description", with: nil)
      click_on("Save")
      expect(page).to have_selector("li", text: "Description can't be blank")
    end

    it "and with invalid Emoji is not saved" do
      fill_in("Emoji", with: nil)
      click_on("Save")
      expect(page).to have_selector("li",
        text: "Emoji should look like an emoji text input, e.g. :an_emoji:")
    end

    it "and with unknown Emoji is set a default one" do
      fill_in("Emoji", with: ":#{Faker::Lorem.word}:")
      click_on("Save")
      expect(page).to have_selector(".alert-warning",
        text: "You provided an invalid emoji! A default one (❤) has been setted")
    end
  end

  it "can show its profile" do
    visit(profile_path(conversation))
    expect(page).to have_selector("h3", text: conversation.name)
  end
end
