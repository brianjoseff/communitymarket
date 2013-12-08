require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'Posts' do
  describe "create a post without premium accoutrement and notify one group" do
    before do
      @post = create(:post)
      @group = create(:group_with_members)
      @user = create(:user)
      login_as(@user, scope: :user)
    end

    it "should create a new post, email memberes of that group, and not charge a credit card" do
      visit '/posts/new'
      fill_in "post_title", with: "Name Surname"
      fill_in "post_description", with: "blah blah blah"
      #fill_in "user_password", with: "password1234"
      # page.check('post_assignments_attributes')
      
      expect { click_button "Upload your post!" }.to change {Post.count}.by(1)
    end
  end
end