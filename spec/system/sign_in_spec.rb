require "rails_helper"

RSpec.describe "sign in" do
  before(:each) do
    create(:user, username: "tyler", password: "eseltyler",
           password_confirmation: "eseltyler")
    visit(root_path)
    click_on("Sign In")
  end

  it "with valid data" do
    fill_in("Username", with: "tyler")
    fill_in("Password", with: "eseltyler")
    click_on("Log in")
    expect(page).to have_selector(".alert-primary", text: "Welcome back!")
    expect(page).to have_selector("h3", text: "My conversations")
  end

  context "incorrectly" do
    it "with invalid password" do
      fill_in("Username", with: "tyler")
      fill_in("Password", with: "soyeltyler")
      click_on("Log in")
      expect(page).to have_selector("li", text: "Password is not valid")
    end

    it "with invalid username" do
      fill_in("Username", with: "tyle")
      fill_in("Password", with: "soyeltyler")
      click_on("Log in")
      expect(page).to have_selector("li", text: "Username is not valid")
    end
  end
end
