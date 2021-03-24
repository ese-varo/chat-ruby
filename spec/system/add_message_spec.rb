require "rails_helper"

RSpec.describe "A message" do
  let!(:user) { create(:user) }
  let!(:conversation) { create(:conversation, users: [user]) }
  let!(:message) { create(:message, user: user, conversation: conversation) }
  before(:each) do
    visit(sign_in_path)
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    click_on("Log in")
    visit(conversation_path(conversation))
  end

  it "has a user" do
    expect(message.user).to have_attributes(username: user.username)
  end

  it "has a conversation" do
    expect(message.conversation).to have_attributes(name: conversation.name)
  end

  it "is displayed correctly" do
    expect(page).to have_selector("div", text: message.content)
    expect(page).to have_selector("p", text: message.user.username)
  end

  it "can be edited and saved with valid data" do
    click_on("update-#{message.id}")
    expect(page).to have_selector("h3", text: "Edit message")
  end

  it "can be edited and not be saved with invalid data" do
    second_message = build(:message)
    click_on("update-#{message.id}")
    expect(current_path).to eq(edit_conversation_message_path(conversation, message))
    fill_in("Message", with: second_message.content)
    click_on("Save")
    expect(page).to have_selector("#message_#{message.id} .card-body .row .content",
                                  text: second_message.content)
  end

  it "is not updated with invalid data" do
    previous_message_content = message.content
    click_on("update-#{message.id}")
    fill_in("Message", with: nil)
    click_on("Save")
    expect(page).to have_selector("#message_#{message.id} .card-body .row .content",
                                  text: previous_message_content)
  end

  it "can be deleted" do
    click_on("delete-#{message.id}")
    expect(page).to have_selector("#message_#{message.id} .card-body .content", text: "This message was removed")
  end
end
