namespace :db do
  desc "add bunch of stuff"
  task :burst_of_activity => :environment do
    require 'faker'
    require 'forgery'


    #users
    15.times do |n|
      name = Faker::Name.name
      email = Faker::Name.first_name + '@' + Forgery(:LoremIpsum).word(:random => true) + '.edu'
      password = Forgery(:basic).password + "123"
      # zip = Forgery(:address).zip
      User.create!(:name => name,
                   :email => email,
                   :password => password)
    end

    #groups
    10.times do |y|
      name = Forgery(:LoremIpsum).word(:random => true) + " group"
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 1, :at_most => 15)
      group_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)
      zip_code = Faker::Address.zip_code
      email_setting_id = 1
      group = Group.create!(:name => name,
                    :description => description,
                    :user_id => user_id,
                    :group_category_id => group_category_id,
                    :zipcode => zip_code)
      Membership.create!(:group_id => group.id, :member_id => user_id, :email_setting_id => email_setting_id)
    end

    #private groups
    10.times do |x|
      name = Forgery(:LoremIpsum).word(:random => true) + " PRIVATE group"
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 20, :at_most => 40)
      group_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)
      zip_code = Faker::Address.zip_code
      password = Forgery(:basic).password
      email_setting_id = 1
      group = Group.create!(:name => name,
                    :description => description,
                    :user_id => user_id,
                    :group_category_id => group_category_id,
                    :zipcode => zip_code,
                    :password => password,
                    :private => true)
      Membership.create!(:group_id => group.id, :member_id => user_id, :email_setting_id => email_setting_id)
    end



    #posts
    20.times do |x|
      title = Forgery(:LoremIpsum).word(:random => true)
      tier_id = nil
      price = Forgery(:Basic).number(:at_least=> 1, :at_most => 40)
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 20, :at_most => 40)
      email = User.find(user_id).email
      post_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)

      Post.create!(:title => title,
                   :price => price,
                   :email => email,
                   :tier_id => tier_id,
                   :description => description,
                   :user_id => user_id,
                   :post_category_id => post_category_id)

    end
    20.times do |x|
      title = Forgery(:LoremIpsum).word(:random => true)
      tier_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 6)
      price = nil
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 20, :at_most => 40)
      email = User.find(user_id).email
      post_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 3)

      Post.create!(:title => title,
                   :price => price,
                   :email => email,
                   :tier_id => tier_id,
                   :description => description,
                   :user_id => user_id,
                   :post_category_id => post_category_id)

    end

    #memberships
    users = User.all
    users.each { |user|
      2.times do |x|
        begin
          email_setting_id = Forgery(:basic).number(:at_least=> 1, :at_most => 3)
          group_id = Forgery(:Basic).number(:at_least => 1, :at_most => 30)
        end until Membership.create(:group_id => group_id,
                           :member_id => user.id, :email_setting_id => email_setting_id)
      end
    }


    #assignments
    80.times do |x|
      post_id = Forgery(:Basic).number(:at_least => 1, :at_most => 40)
      group_id = Forgery(:Basic).number(:at_least => 1, :at_most => 10)
      Assignment.create!(:post_id => post_id,
                         :group_id => group_id)
    end

  end
end

