namespace :db do
  desc "add thirty groups"
  task :add_groups => :environment do
    require 'faker'
    require 'forgery'

    #users
    30.times do |n|
      name = Faker::Name.name + "group"
      id = User.last(30).sample.id
      
      # zip = Forgery(:address).zip
      Group.create!(:name => name,
                   :user_id => id)
    end
    
  end
end