require "rails_helper"

RSpec.describe "Public conversations without log in" do
  before(:each) do
    5.times { create(:conversation, messages: [create(:message)]) }
  end

  it "display the most active public conversations" do
    conversation = create(:conversation, messages: [create(:message)])
    visit(root_path)
    expect(page).to have_selector("h1", text: "Welcome!")
    within(".card-body") do
      expect(page).to have_selector(
        ".card-title h3", text: "Most Active Public Conversations")
    end
    expect(page).to have_selector("a", text: "Profile", count: 5)
    expect(page).to have_selector("h4", text: conversation.name)
  end

  it "display the profile of a conversation" do
    another_conversation = create(:conversation, messages: [create(:message)])
    visit(root_path)
    find("#conversation_#{another_conversation.id} a").click
    expect(page).to have_selector("h3", text: another_conversation.name)
  end

  it "doesn't allow access private conversations" do
    tyler = create(:user)
    conversation = create(:conversation, status: "private", users: [tyler])
    visit(profile_path(conversation))
    expect(page).to have_selector(".alert-warning", text: "You don't have access to this section 💔")
  end
end
