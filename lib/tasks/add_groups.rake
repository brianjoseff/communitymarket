namespace :db do
  desc "add thirty groups"
  task :add_groups => :environment do
    require 'faker'
    require 'forgery'

    #groups
    30.times do |n|
      name = Faker::Name.name + "group"
      id = User.last(30).sample.id
      group_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 6)
      
      # zip = Forgery(:address).zip
      Group.create!(:name => name,
                   :user_id => id,
                   :group_category_id => group_category_id)
    end
    
  end
end