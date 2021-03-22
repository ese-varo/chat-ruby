require "rails_helper"

RSpec.describe "visit index without log in" do
  it "display the most active public conversations" do
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, messages: [create(:message)])
    create(:conversation, name: 'Rails conversation', messages: [create(:message)])

    visit(root_path)
    expect(page).to have_selector("h1", text: "Welcome!")
    within(".card-body") do
      expect(page).to have_selector(
        ".card-title h3", text: "Most Active Public Conversations")
    end
    expect(page).to have_selector("a", text: "Profile", count: 5)
    expect(page).to have_selector("h4", text: /Rails conversation/)
  end
end
