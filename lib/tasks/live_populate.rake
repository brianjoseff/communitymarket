namespace :db do
  desc "erase and fill database"
  task :live_populate => :environment do
    require 'faker'
    require 'forgery'
    
    [User, Group, DailyQueue, WeeklyQueue, Membership, Asset, Image, Assignment, Followship, Post, PostCategory, GroupCategory, Tag, TaggingTier, EmailSetting].each(&:delete_all)
    [User, Group, DailyQueue, WeeklyQueue, Membership, Asset, Image, Assignment, Followship, Post, PostCategory, GroupCategory, Tag, Tier, EmailSetting].each(&:reset_pk_sequence)
    User.create!(:name => "Brian Joseff",
                 :email => "brianjoseff123@gmail.com",
                 :password => "090909",
                 :admin => true)
   
   #email settings
   EmailSetting.create!(:name => "Each Post", :id => 1)
   EmailSetting.create!(:name => "Daily", :id => 2)
   EmailSetting.create!(:name => "Weekly", :id => 3)
   EmailSetting.create!(:name => "All Groups/Tags Aggregated Per Day", :id => 4)
   EmailSetting.create!(:name => "All Groups/Tags Aggregated Per Week", :id => 5)
   EmailSetting.create!(:name => "Never", :id => 6)
   
   
   #post_categories
   PostCategory.create!(:name => "For Sale")
   PostCategory.create!(:name => "Wanted")
   # PostCategory.create!(:name => "Jobs/Internships")
   # PostCategory.create!(:name => "Free Stuff")
   # PostCategory.create!(:name => "Housing")
   PostCategory.create!(:name => "Borrow/Rent", :id => 4)    

   
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
   
   
   # Group.create!(:name => name,
   #               :description => description,
   #               :user_id => user_id,
   #               :group_category_id => group_category_id)
   # Post.create!(:title => title,
   #              :price => price,
   #              :tier_id => tier_id,
   #              :description => description,
   #              :user_id => user_id,
   #              :post_category_id => post_category_id)
    
  end
end 
    
