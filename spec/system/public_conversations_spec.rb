require "rails_helper"

RSpec.describe "visit index without log in" do
  before(:each) do
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, name: 'Rails conversation', messages: [create(:message)])
  end

  it "display the most active public conversations" do
    visit(root_path)
    expect(page).to have_selector("h1", text: "Welcome!")
    within(".card-body") do
      expect(page).to have_selector(
        ".card-title h3", text: "Most Active Public Conversations")
    end
    expect(page).to have_selector("a", text: "Profile", count: 5)
    expect(page).to have_selector("h4", text: /Rails conversation/)
  end

  it "display the profile of a conversation" do
    another_conversation = create(:conversation,
      name: 'Tell me more!', messages: [create(:message)])
    visit(root_path)
    find("#conversation_#{another_conversation.id} a").click
    expect(page).to have_selector(
      "h3", text: another_conversation.name)
  end
end
