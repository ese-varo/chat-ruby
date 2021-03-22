require "rails_helper"

RSpec.describe "sign up" do
  context "incorrectly" do
    before(:each) do
      visit(root_path)
      click_on("Sign Up")
    end

    it "with existing email" do
      create(:user, email: "already_created@example.com")
      fill_in("Email", with: "already_created@example.com")
      fill_in("Username", with: Faker::Internet.username(specifier: 4..9))
      fill_in("Password", with: "lapassword")
      fill_in("user_password_confirmation", with: "lapassword")
      click_on("Register")
      expect(page).to have_selector("li", text: "Email has already been taken")
    end

    it "with invalid email" do
      fill_in("Email", with: "already_created@examplecom")
      click_on("Register")
      expect(page).to have_selector("li", text: "Email should look like an email address")
    end

    describe "with password" do
      it "invalid" do
        fill_in("Password", with: "short")
        fill_in("user_password_confirmation", with: "short")
        click_on("Register")
        expect(page).to have_selector("li",
          text: "Password is too short (minimum is 8 characters)")
      end

      it "unmatching" do
        fill_in("Password", with: "lapassword")
        fill_in("user_password_confirmation", with: "lapas")
        click_on("Register")
        expect(page).to have_selector("li",
          text: "Password confirmation doesn't match Password")
      end

      it "missing" do
        fill_in("Password", with: nil)
        fill_in("user_password_confirmation", with: nil)
        click_on("Register")
        expect(page).to have_selector("li", text: "Password can't be blank")
      end
    end

    it "with invalid username" do
      fill_in("Username", with: nil)
      click_on("Register")
      expect(page).to have_selector("li", text: "Username can't be blank")
    end
  end

  it "with valid data" do
    visit(root_path)
    click_on("Sign Up")
    fill_in("Email", with: Faker::Internet.email)
    fill_in("Username", with: Faker::Internet.username(specifier: 4..9))
    fill_in("Password", with: "lapassword")
    fill_in("user_password_confirmation", with: "lapassword")
    click_on("Register")
    expect(page).to have_selector(".alert-primary", text: "Account registered!")
    expect(page).to have_selector("h3", text: "My conversations")
  end
end
