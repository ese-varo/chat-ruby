require "rails_helper"

RSpec.describe "A message" do
  let!(:tyler) { create(:user, username: "tyler", password: "eseltyler",
                 password_confirmation: "eseltyler") }
  let!(:conversation) { create(:conversation,
                 name: "La vida es como una lenteja", users: [tyler]) }
  let!(:message) { create(:message, content: "Don't give up!", user: tyler,
                          conversation: conversation) }
  before(:each) do
    visit(sign_in_path)
    fill_in("Username", with: "tyler")
    fill_in("Password", with: "eseltyler")
    click_on("Log in")
  end

  it "has a user" do
    expect(message.user).to have_attributes(username: "tyler")
  end

  it "has a conversation" do
    expect(message.conversation).to have_attributes(name: conversation.name)
  end

  it "is displayed correctly" do
    visit(conversation_path(conversation))
    expect(page).to have_selector("div", text: message.content)
    expect(page).to have_selector("p", text: message.user.username)
  end

  it "can be edited and saved with valid data" do
    visit(conversation_path(conversation))
    click_on("update-#{message.id}")
    expect(page).to have_selector("h3", text: "Edit message")
  end

  it "can be edited and not be saved with invalid data" do
    visit(conversation_path(conversation))
    click_on("update-#{message.id}")
    expect(current_path).to eq(edit_conversation_message_path(conversation, message))
    fill_in("Message", with: "Hola Mundo!")
    click_on("Save")
    expect(page).to have_selector("#message_#{message.id} .card-body .row .content", text: "Hola Mundo!")
  end

  it "is not updated with invalid data" do
    visit(conversation_path(conversation))
    click_on("update-#{message.id}")
    fill_in("Message", with: "")
    click_on("Save")
    expect(page).to have_selector("#message_#{message.id} .card-body .row .content", text: "Don't give up!")
  end

  it "can be deleted" do
    visit(conversation_path(conversation))
    click_on("delete-#{message.id}")
    expect(page).to have_selector("#message_#{message.id} .card-body .content", text: "This message was removed")
  end
end
