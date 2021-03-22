require "rails_helper"

RSpec.describe "sign up" do
  context "incorrectly" do
    before(:each) do
      visit(root_path)
      click_on("Sign Up")
    end

    it "with existing email" do
      registered_user = create(:user)
      password = Faker::Internet.password(min_length: 8)
      username = Faker::Internet.username(specifier: 4..9)
      fill_in("Email", with: registered_user.email)
      fill_in("Username", with: username)
      fill_in("Password", with: password)
      fill_in("user_password_confirmation", with: password)
      click_on("Register")
      expect(page).to have_selector("li", text: "Email has already been taken")
    end

    it "with invalid email" do
      fill_in("Email", with: "invalid@examplecom")
      click_on("Register")
      expect(page).to have_selector("li", text: "Email should look like an email address")
    end

    describe "with password" do
      it "invalid" do
        short_password = Faker::Internet.password(min_length: 5, max_length: 7)
        fill_in("Password", with: short_password)
        fill_in("user_password_confirmation", with: short_password)
        click_on("Register")
        expect(page).to have_selector("li",
          text: "Password is too short (minimum is 8 characters)")
      end

      it "unmatching" do
        fill_in("Password", with: Faker::Internet.password)
        fill_in("user_password_confirmation", with: Faker::Internet.password)
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
    user = build(:user)
    visit(root_path)
    click_on("Sign Up")
    fill_in("Email", with: user.email)
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    fill_in("user_password_confirmation", with: user.password)
    click_on("Register")
    expect(page).to have_selector(".alert-primary", text: "Account registered!")
    expect(page).to have_selector("h3", text: "My conversations")
  end
end
