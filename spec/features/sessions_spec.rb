require 'spec_helper'

feature "Signing in" do
  background do
    @user = create(:user, :email=> "brian@example.com")
    @tag = create(:tag)
    @group = create(:group)
  end

  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'
    within("#session") do
      fill_in 'user_email', :with => 'brian@example.com'
      fill_in 'user_password', :with => 'password'
    end
    click_button 'Sign In'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario "after redirect to sign in, tag is followed" do
    visit tag_path(@tag)
    click_button "follow"
    click_link "Sign In"
    within("#session") do
      fill_in 'user_email', :with => 'brian@example.com'
      fill_in 'user_password', :with => 'password'
    end
    expect { click_button "Sign In" }.to change {Followship.count}.by(1)
    expect(page).to have_content 'successfully signed in.'
  end
  
  scenario "after redirect to sign in, group is joined" do
    visit group_path(@group)
    click_button "Join"
    click_link "Sign In"
    within("#session") do
      fill_in 'user_email', :with => 'brian@example.com'
      fill_in 'user_password', :with => 'password'
    end
    expect { click_button "Sign In" }.to change {Membership.count}.by(1)
    expect(page).to have_content 'successfully signed in.'
  end
  # given(:other_user) { User.create(:email => 'other@example.com', :password => 'password') }
  # 
  # scenario "Signing in as another user" do
  #   visit '/users/sign_in'
  #   within("#session") do
  #     fill_in 'user_email', :with => other_user.email
  #     fill_in 'user_password', :with => other_user.password
  #   end
  #   click_button 'Sign in'
  #   expect(page).to have_content 'Invalid email or password'
  # end
end