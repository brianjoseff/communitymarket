require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'Posts' do
  describe "create a post without premium accoutrement and notify one group" do
    before do
      @post = create(:post)
      @group = create(:group_with_members)
      @user = @group.members.first
      login_as(@user, scope: :user)
      
    end

    it "should create a new post, email memberes of that group, and not charge a credit card" do
      visit '/posts/new'
      fill_in "post_title", with: "Name Surname"
      fill_in "post_description", with: "blah blah blah"
      #fill_in "user_password", with: "password1234"
      page.check('Mystring')
      
      expect { click_button "Upload your post!" }.to change {Post.count && Assignment.count}.by(1)
    end
  end
  
  describe "non-facebook user posts and shares via facebook" do
    before do
      @post = create(:post)
      @group = create(:group_with_members)
      @user = @group.members.first
      login_as(@user, scope: :user)
      
    end
    it "should post item and update their user attributes to be facebook enabled" do

      visit '/posts/new'
      fill_in "post_title", with: "Name Surname"
      fill_in "post_description", with: "blah blah blah"
      #fill_in "user_password", with: "password1234"
      page.check('Share on facebook')
      expect { click_button "Upload your post!" }.to change {Post.count}.by(1)
      save_and_open_page
      expect(page).to have_content 'Your facebook account'
      
    end
  end
  
  
end