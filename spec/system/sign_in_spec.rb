require "rails_helper"

RSpec.describe "sign in" do
  let!(:user) { create(:user) }
  before(:each) do
    visit(root_path)
    click_on("Sign In")
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
  end

  it "with valid data" do
    click_on("Log in")
    expect(page).to have_selector(".alert-primary", text: "Welcome back!")
    expect(page).to have_selector("h3", text: "My conversations")
  end

  it "and enters to a normal session correctly" do
    click_on("Log in")
    expect(page).to have_selector(".alert-primary", text: "Welcome back!")
    expect(page).to have_selector(".navbar-text", text: user.email)
  end

  context "incorrectly" do
    it "with invalid password" do
      fill_in("Password", with: "soyeltyler")
      click_on("Log in")
      expect(page).to have_selector("li", text: "Password is not valid")
    end

    it "with invalid username" do
      fill_in("Username", with: "tyle")
      click_on("Log in")
      expect(page).to have_selector("li", text: "Username is not valid")
    end
  end
end
