namespace :db do
  desc "set group categories"
  task :set_group_categories => :environment do
    # require 'faker'
    # require 'forgery'
    GroupCategory.delete_all
    GroupCategory.reset_pk_sequence
    #categories
    GroupCategory.create!(:name => "Greek", :id => 1)
    GroupCategory.create!(:name => "Sport", :id => 2)
    GroupCategory.create!(:name => "Club", :id => 3)
    GroupCategory.create!(:name => "Department", :id => 4)
    GroupCategory.create!(:name => "Dorm/Cluster", :id => 5)
    GroupCategory.create!(:name => "Other", :id => 6)
    
  end
end 
