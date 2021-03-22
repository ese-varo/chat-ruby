require "rails_helper"

RSpec.describe "sign out" do
  let(:user) { create(:user) }
  it "successfully" do
    visit(sign_in_path)
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    click_on("Log in")
    click_on("Sign Out")
    expect(page).to have_selector(".alert-primary", text: "Goodbye!")
    expect(page).to have_selector("h3", text: "Most Active Public Conversations")
  end
end
