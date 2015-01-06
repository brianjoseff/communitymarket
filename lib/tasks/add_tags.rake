namespace :db do
  desc "add tags"
  task :add_tags => :environment do
    require 'faker'
    require 'forgery'




    #tags
    15.times do |n|
      name = Forgery(:LoremIpsum).word(:random => true)
      desc = Forgery(:LoremIpsum).paragraph(:random => true)

      # zip = Forgery(:address).zip
      Tag.create!(:name => name,
                  :description => desc)
    end




    #posts
    20.times do |x|
      title = Forgery(:LoremIpsum).word(:random => true)
      tier_id = nil
      price = Forgery(:Basic).number(:at_least=> 1, :at_most => 40)
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 3, :at_most => 12)
      email = User.find(user_id).email
      post_category_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 5)

      Post.create!(:title => title,
                   :price => price,
                   :email => email,
                   :tier_id => tier_id,
                   :description => description,
                   :user_id => user_id,
                   :post_category_id => post_category_id)

    end
    20.times do |x|
      title = Forgery(:LoremIpsum).word(:random => true)
      tier_id = Forgery(:Basic).number(:at_least=> 1, :at_most => 6)
      price = nil
      description = Forgery(:LoremIpsum).paragraph(:random => true)
      user_id = Forgery(:Basic).number(:at_least => 3, :at_most => 12)
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
    80.times do |x|
      post_id = Forgery(:Basic).number(:at_least => 1, :at_most => 40)
      tag_id = Forgery(:Basic).number(:at_least => 1, :at_most => 10)
      Tagging.create!(:post_id => post_id,
                      :tag_id => tag_id)
    end

  end
end