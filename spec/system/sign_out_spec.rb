require "rails_helper"

RSpec.describe "sign out" do
  before do
    create(:user, username: "tyler", password: "eseltyler",
           password_confirmation: "eseltyler")
    visit(root_path)
    click_on("Sign In")
    fill_in("Username", with: "tyler")
    fill_in("Password", with: "eseltyler")
    click_on("Log in")
  end

  it "successfully" do
    click_on("Sign Out")
    expect(page).to have_selector(".alert-primary", text: "Goodbye!")
    expect(page).to have_selector("h3", text: "Most Active Public Conversations")
  end
end
