namespace :db do
  desc "add members to a group"
  task :memberfy => :environment do
    require 'faker'
    require 'forgery'
    
    #users
    30.times do |n|
      name = Faker::Name.name
      email = Faker::Name.first_name + '@' + Forgery(:LoremIpsum).word(:random => true) + '.edu'
      password = Forgery(:basic).password
      # zip = Forgery(:address).zip
      User.create!(:name => name,
                   :email => email,
                   :password => password)
    end
    
    #memberships
    users = User.last(30)
    group = Group.find(8)
    users.each { |user|
      Membership.create(:group_id => group.id,
                           :member_id => user.id,
                           :email_setting_id => Forgery(:Basic).number(:at_least => 1, :at_most => 6))
    }

    
  end
end 
    
