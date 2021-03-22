require "rails_helper"

RSpec.describe "A conversation" do
  let!(:tyler) { create(:user, username: "tyler", password: "eseltyler",
                 password_confirmation: "eseltyler") }
  let!(:conversation) { create(:conversation,
                 name: "La vida es como una lenteja", users: [tyler]) }
  before(:each) do
    visit(sign_in_path)
    fill_in("Username", with: "tyler")
    fill_in("Password", with: "eseltyler")
    click_on("Log in")
  end

  it "has a user" do
    expect(conversation.users.first).to have_attributes(username: "tyler")
  end

  it "can have messages" do
    conversation.messages << create_list(:message, 5, user: tyler)
    expect(conversation.messages.count).to be 5
  end

  it "is displayed correctly" do
    find("#btn-see-#{conversation.id}").click
    expect(page).to have_selector("h3", text: conversation.name)
  end

  describe "can be edited" do
    before(:each) do
      create(:user, username: 'Groot')
      visit(edit_conversation_path(conversation))
    end

    it "and with correct data is saved successfully" do
      fill_in("Title", with: "Lets talk about COBOL")
      fill_in("Description", with: "He is a pretty old boy")
      fill_in("Emoji", with: ":rainbow:")
      check('Groot')
      click_on("Save")
      expect(page).to have_selector("h3", text: "Lets talk about COBOL")
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
      fill_in("Emoji", with: ":oh_no:")
      click_on("Save")
      expect(page).to have_selector(".alert-warning",
        text: "You provided an invalid emoji! A default one (❤) has been setted")
    end
  end

  it "can show its profile" do
    visit(profile_path(conversation))
    expect(page).to have_selector("h3", text: conversation.name)
  end

  xit "can be deleted" do
    visit(root_path)
    click_on("Delete")
    expect(page).not_to have_selector("h4", text: conversation.name)
  end
end
