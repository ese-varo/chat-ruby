require "rails_helper"

RSpec.describe "A shared conversation" do
  let(:user) { create(:user) }
  before(:each) do
    visit(sign_in_path)
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    click_on("Log in")
  end

  let!(:second_user) { create(:user) }

  it "has more than one participant" do
    shared_conversation = create(:conversation, users: [user, second_user])
    visit(start_conversation_path)
    expect(page).to have_selector(".title", text: "Chat with others")
    expect(page).to have_selector("#conversations-with-#{second_user.username}")
    expect(page).to have_selector("p", text: "#{second_user.username}")
    first("#conversation_id").click
    find("option", text: shared_conversation.name).click
    click_on("See chat")
    expect(page).to have_selector("h3", text: shared_conversation.name)
  end
end
