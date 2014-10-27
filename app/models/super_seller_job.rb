class SuperSellerJob < ActiveRecord::Base
  attr_accessible :owner_id, :super_seller_id, :estimated_value, :sell_options, :pickup_location, :notes, :status

  belongs_to :user, :foreign_key => :owner_id

  validates :estimated_value, :presence => true
  validates :pickup_location, :presence => true

  def seller
    return self.super_seller_id ? User.find(self.super_seller_id) : nil
  end

  def owner_hidden
    name = User.find(self.owner_id).name
    name.split(" ").map do |name|
      name[0] + "***"
    end.join(" ")
  end

  def status_html
    case self.status
    when 'active'
      return '<span class="available">Avail. for pickup!</span>'.html_safe
    when 'inprogress'
      return '<span class="in-progress">In progress...</span>'.html_safe
    else
      ''
    end
  end

end
