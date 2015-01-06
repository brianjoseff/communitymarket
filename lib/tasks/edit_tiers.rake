

namespace :db do
  desc "change names of tiers"
  task :edit_tier => :environment do

    PostCategory.delete_all
    PostCategory.reset_pk_sequence

    #current production db Post Categories
    PostCategory.create!(:name => "For Sale", id: 1)
    PostCategory.create!(:name => "Wanted", id: 2)
    # PostCategory.create!(:name => "Jobs/Internships")
    # PostCategory.create!(:name => "Free Stuff")
    PostCategory.create!(:name => "Housing", id: 6)
    PostCategory.create!(:name => "Textbook", id: 7)
    PostCategory.create!(:name => "Request Service", id: 4)
    PostCategory.create!(:name => "Offer Service", id: 5)

  end

end 
