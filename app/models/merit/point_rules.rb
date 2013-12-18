# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      
      # score 3, to: :user, on: 'posts#create' do |post|
      #   #post.post_category.name == "For Sale" || post.post_category.name == "Borrow/Rent"
      #   # post.title.present?
      #   # if post.assets.first
      #   #   !post.assets.image_file_name.present?
      #   # end
      # end
      score 3, to: :user, on: 'posts#create'
      # score 5, :on => 'posts#create', :to => :user do |post|
      #   post.post_category.name == "For Sale" || "Borrow/Rent"
      #   post.title? && post.assets.first.image_file_name?
      # end
      
      score 5, :on => 'messages#create' do |message|
        message.content?
        message.recipient != message.sender
      end
      
      score 10, :on => 'transactions#create' do |transaction|
        #transaction completed
      end

      # score 10, :on => 'users#update' do
      #   user.name.present?
      # end
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      # score 20, :on => [
      #   'comments#create',
      #   'photos#create'
      # ]
    end
  end
end
