require "rails_helper"

RSpec.describe "A conversation" do
  before(:each) do
    create(:user, username: "tyler", password: "eseltyler",
           password_confirmation: "eseltyler")
    visit(sign_in_path)
    fill_in("Username", with: "tyler")
    fill_in("Password", with: "eseltyler")
    click_on("Log in")
  end

  let!(:ramon) { create(:user, username: 'ramon') }
  let!(:dolores) { create(:user, username: 'dolores') }

  it "can be started correctly" do
    click_on("New chat")
    expect(page).to have_selector("p", text: "Who do you want to chat with?")
    fill_in("Title", with: "Lets talk about COBOL")
    fill_in("Description", with: "He is a pretty old boy")
    fill_in("Emoji", with: ":rainbow:")
    check(ramon.username)
    check(dolores.username)
    click_on("Save")
    expect(page).to have_selector("h3", text: "Lets talk about COBOL")
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
    fill_in("Title", with: "Lets talk about COBOL")
    fill_in("Description", with: "He is a pretty old boy")
    fill_in("Emoji", with: ":perrito:")
    check(ramon.username)
    check(dolores.username)
    click_on("Save")
    expect(page).to have_selector(".alert-warning",
      text: "You provided an invalid emoji! A default one (❤) has been setted")
  end
end
