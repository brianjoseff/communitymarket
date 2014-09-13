namespace :db do
  desc "erase and fill database"
  task :live_populate => :environment do
    require 'faker'
    require 'forgery'

    [User, Group, DailyQueue, WeeklyQueue, Membership, Asset, Image, Assignment, Followship, Post, PostCategory, GroupCategory, Tag, Tagging, Tier, EmailSetting, Transaction].each(&:delete_all)
    [User, Group, DailyQueue, WeeklyQueue, Membership, Asset, Image, Assignment, Followship, Post, PostCategory, GroupCategory, Tag, Tagging, Tier, EmailSetting, Transaction].each(&:reset_pk_sequence)
    User.create!(:name => "Brian Joseff",
                 :email => "admin1@gmail.com",
                 :password => "09090909",
                 :admin => true)
    User.create!(:name => "Peter Loomis", :email => "admin2@gmail.com",
      :password => "09090909", :admin => true)

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
    Tier.create!(:name => "$1-5: Tier 1", :price => 250, :id => 1)
    Tier.create!(:name => "$6-10: Tier 2", :price => 600, :id => 2)
    Tier.create!(:name => "$11-25: Tier 3", :price => 1200, :id => 3)
    Tier.create!(:name => "$26-50: Tier 4", :price => 3000, :id => 4)
    Tier.create!(:name => "$51-99: Tier 5", :price => 6000, :id => 5)
    Tier.create!(:name => "$100+: Tier 6", :price => 1100, :id => 6)


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