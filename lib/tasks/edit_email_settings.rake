namespace :db do
  desc "update email settings"
  task :edit_email_settings => :environment do
    require 'faker'
    require 'forgery'
    EmailSetting.delete_all
    EmailSetting.reset_pk_sequence
    #tiers
    EmailSetting.create!(:name => "Each Post", :id => 1)
    EmailSetting.create!(:name => "Daily", :id => 2)
    EmailSetting.create!(:name => "Weekly", :id => 3)
    EmailSetting.create!(:name => "All Groups/Tags Aggregated Per Day", :id => 4)
    EmailSetting.create!(:name => "All Groups/Tags Aggregated Per Week", :id => 5)
    EmailSetting.create!(:name => "Never", :id => 6)
    
  end
end 

