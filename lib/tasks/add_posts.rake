namespace :db do
  desc "add bunch of posts"
  task :add_posts => :environment do
    require 'faker'
    require 'forgery'

    
   
    
    40.times do |x|
      title = Forgery(:LoremIpsum).word(:random => true)
      tier_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 6)
      price = nil
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = User.last(30).sample.id
      email = User.find(user_id).email
      post_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 3)
      
      Post.create!(:title => title,
                   :price => price,
                   :email => email,
                   :tier_id => tier_id,
                   :description => description,
                   :user_id => user_id,
                   :post_category_id => post_category_id)
    
    end
    
    
    #assignments
    100.times do |x|
      post_id = Post.last(40).sample.id
      group_id = Group.last(30).sample.id
      Assignment.create!(:post_id => post_id,
                         :group_id => group_id)
    end
    
  end
end
    
