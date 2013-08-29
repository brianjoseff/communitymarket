namespace :db do
  desc "create a bunch of memerships"
  task :membership_flurry => :environment do
    require 'faker'
    require 'forgery'

    
  
    
    #memberships
    users = User.last(30)
    users.each { |user|
      3.times do |x|
        begin 
          email_setting_id = Forgery(:basic).number(:at_least=> 1, :at_most => 3)
          group_id = Group.last(30).sample.id
        end until Membership.create(:group_id => group_id,
                           :member_id => user.id, :email_setting_id => email_setting_id)
      end
    }
    
    
    
  end
end
    
