namespace :db do
  desc "set schools"
  task :set_schools => :environment do
    # require 'faker'
    # require 'forgery'
    School.delete_all
    School.reset_pk_sequence
    #categories
    School.create!(:name => "Dartmouth", :id => 1)
    School.create!(:name => "U of Oregon", :id => 2)

    
  end
end 
