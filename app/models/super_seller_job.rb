class SuperSellerJob < ActiveRecord::Base
  attr_accessible :owner_id, :super_seller_id, :estimated_value, :sell_options, :pickup_location, :notes

  belongs_to :user

  validates :estimated_value, :presence => true
  validates :pickup_location, :presence => true


end
