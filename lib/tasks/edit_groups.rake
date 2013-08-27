namespace :db do
  desc "change groups"
  task :edit_groups => :environment do
    require 'faker'
    require 'forgery'
    Group.delete_all
    Group.reset_pk_sequence
    #groups
    10.times do |y|
      name = Forgery(:LoremIpsum).word(:random => true) + " group"
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 1, :at_most => 15)
      group_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)
      zip_code = Faker::Address.zip_code
      Group.create!(:name => name,
                    :description => description,
                    :user_id => user_id,
                    :group_category_id => group_category_id,
                    :zipcode => zip_code)
    end
    
    #private groups    
    10.times do |x|
      name = Forgery(:LoremIpsum).word(:random => true) + " PRIVATE group"
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 1, :at_most => 15)
      group_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)
      zip_code = Faker::Address.zip_code
      password = Forgery(:basic).password
      Group.create!(:name => name,
                    :description => description,
                    :user_id => user_id,
                    :group_category_id => group_category_id,
                    :zipcode => zip_code,
                    :password => password,
                    :private => true)
    end
    
  end
end 
