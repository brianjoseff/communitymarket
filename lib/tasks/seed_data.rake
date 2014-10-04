namespace :db do
  desc "erase and fill database"
  task :seed_data => :environment do
    require 'faker'
    require 'forgery'
    
    [User, Group, DailyQueue, WeeklyQueue, Membership, Asset, Image, Assignment, Followship, Post, PostCategory, GroupCategory, Tag, Tagging, Tier, EmailSetting, Transaction].each(&:delete_all)
    [User, Group, DailyQueue, WeeklyQueue, Membership, Asset, Image, Assignment, Followship, Post, PostCategory, GroupCategory, Tag, Tagging, Tier, EmailSetting, Transaction].each(&:reset_pk_sequence)
    User.create!(:name => "admin",
                 :email => "admin@gmail.com",
                 :password => "09090909", admin: true)
    
    #users
    15.times do |n|
      name = Faker::Name.name
      email = Faker::Name.first_name + '@' + Forgery(:LoremIpsum).word(:random => true) + '.edu'
      password = Forgery(:basic).password + '09090909'
      # zip = Forgery(:address).zip
      User.create!(:name => name,
                   :email => email,
                   :password => password)
    end
    
    #group data
    10.times do |y|
      name = Forgery(:LoremIpsum).word(:random => true) + " group"
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 1, :at_most => 15)
      group_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)
      Group.create!(:name => name,
                    :description => description,
                    :user_id => user_id,
                    :group_category_id => group_category_id)
    end
    
    #post_categories
    PostCategory.create!(:name => "For Sale")
    PostCategory.create!(:name => "Wanted")
    # PostCategory.create!(:name => "Jobs/Internships")
    # PostCategory.create!(:name => "Free Stuff")
    PostCategory.create!(:name => "Housing")
    PostCategory.create!(:name => "Textbook")
    PostCategory.create!(:name => "Request Service")
    PostCategory.create!(:name => "Offer Service")    

    
    #group_categories
    GroupCategory.create!(:name => "Greek")
    GroupCategory.create!(:name => "Sport")
    GroupCategory.create!(:name => "Club")
    GroupCategory.create!(:name => "Department")
    GroupCategory.create!(:name => "Dorm/Cluster")
    GroupCategory.create!(:name => "Other")
    
    #tiers
    Tier.create!(:name => "$1-5: Tier 1", :price => 250, :id => 1)
    Tier.create!(:name => "$6-10: Tier 2", :price => 600, :id => 2)
    Tier.create!(:name => "$11-25: Tier 3", :price => 1200, :id => 3)
    Tier.create!(:name => "$26-50: Tier 4", :price => 3000, :id => 4)
    Tier.create!(:name => "$51-99: Tier 5", :price => 6000, :id => 5)
    Tier.create!(:name => "$100+: Tier 6", :price => 1100, :id => 6)
    
    
    #posts
    20.times do |x|
      title = Forgery(:LoremIpsum).word(:random => true)
      tier_id = nil
      price = Forgery(:Basic).number(:at_least=> 1, :at_most => 40)
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 1, :at_most => 15)
      post_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)
      
      Post.create!(:title => title,
                   :price => price,
                   :tier_id => tier_id,
                   :description => description,
                   :user_id => user_id,
                   :post_category_id => post_category_id)
    
    end
    
    #tier posts
    20.times do |x|
      title = Forgery(:LoremIpsum).word(:random => true)
      tier_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 6)
      price = nil
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 1, :at_most => 15)
      post_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)
      
      Post.create!(:title => title,
                   :price => price,
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
          group_id = Forgery(:Basic).number(:at_least => 1, :at_most => 10)
        end until Membership.create(:group_id => group_id,
                           :member_id => user.id)
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