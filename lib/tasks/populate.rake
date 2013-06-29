namespace :db do
  desc "erase and fill database"
  task :populate => :environment do
    require 'faker'
    require 'forgery'
    
    [User, Group, Membership, Assignment, Post, PostCategory, GroupCategory, Tier].each(&:delete_all)
    User.create!(:name => "Brian",
                 :email => "b@b.edu",
                 :password => "000000")
    
    #users
    15.times do |n|
      name = Faker::Name.name
      email = Faker::Name.first_name + '@' + Forgery(:LoremIpsum).word(:random => true) + '.edu'
      password = Forgery(:basic).password
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
    # PostCategory.create!(:name => "Housing")
    PostCategory.create!(:name => "Other")    

    
    #group_categories
    GroupCategory.create!(:name => "Interest")
    GroupCategory.create!(:name => "School")
    GroupCategory.create!(:name => "Business")
    GroupCategory.create!(:name => "Organization")
    GroupCategory.create!(:name => "Region")
    
    #tiers
    Tier.create!(:name => "$1-5", :id => "1")
    Tier.create!(:name => "$6-10", :id => "2")
    Tier.create!(:name => "$11-25", :id => "3")
    Tier.create!(:name => "$26-50", :id => "4")
    Tier.create!(:name => "$51-99", :id => "5")
    Tier.create!(:name => "$100+", :id => "6")
    
    
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
    
