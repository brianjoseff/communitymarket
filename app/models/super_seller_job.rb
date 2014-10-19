class SuperSellerJob < ActiveRecord::Base
  attr_accessible :owner_id, :super_seller_id, :estimated_value, :sell_options, :pickup_location, :notes

  belongs_to :user

  validates :estimated_value, :presence => true
  validates :pickup_location, :presence => true


  def owner
    User.find(self.owner_id).name
  end

  def owner_hidden
    name = User.find(self.owner_id).name
    name.split(" ").map do |name|
      name[0] + "***"
    end.join(" ")
  end

end
