require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'Users' do
  before do
    @tag = create(:tag)
    @group = create(:group)
    @user = create(:user, :email=> "brian@example.com")
  end
  
  
  describe "clicking sign up on nav" do
    it "should take user to devise page and sign them up" do
      visit root_path
      click_link "Sign Up"
      fill_in "user_name", with: "Name Surname"
      fill_in "user_email", with: "name@mail.com"
      fill_in "user_password", with: "password1234"
      expect { click_button "Sign Up" }.to change {User.count}.by(1)
    end
  end
  
  describe "clicking sign in on nav" do
    it "should take user to devise page and sign them in" do
      visit root_path
      click_link "Sign In"
      fill_in "user_email", with: "brian@example.com"
      fill_in "user_password", with: "password"
      click_button "Sign In"
      expect(page).to have_content 'Signed in successfully.'
    end
  end
      
  
  
  
  
  
  describe "GET /users/sign_up" do


    it "should create a new user account" do
      visit new_user_registration_path
      fill_in "user_name", with: "Name Surname"
      fill_in "user_email", with: "name@mail.com"
      fill_in "user_password", with: "password1234"
      
      expect { click_button "Sign Up" }.to change {User.count}.by(1)
    end
  end
  describe "GET /users/id" do
    before do
      @user = create(:user)
      login_as(@user, scope: :user)
    end
    it "should show the user's profile page" do
      visit user_path(@user)
      expect(page).to have_content "Profile Page"
    end
  end
  
  describe "after redirect to sign up, account created and follows tag" do
    it "should create a new user account" do
      visit tag_path(@tag)
      click_button "follow"
      fill_in "user_name", with: "Name Surname"
      fill_in "user_email", with: "name@mail.com"
      fill_in "user_password", with: "password1234"
      
      expect { click_button "Sign Up" }.to change {User.count && Followship.count}.by(1)
    end
  end
  describe "after redirect to sign up, account created and joins group" do
    it "should create a new user account" do
      visit group_path(@group)
      click_button "Join"
      fill_in "user_name", with: "Name Surname"
      fill_in "user_email", with: "name@mail.com"
      fill_in "user_password", with: "password1234"
      
      expect { click_button "Sign Up" }.to change {User.count && Membership.count}.by(1)
    end
  end
end