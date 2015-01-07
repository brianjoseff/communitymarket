class Group < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord
  geocoded_by :zipcode
  after_validation :geocode, :if => :zipcode_changed?
  attr_accessible :description, :group_category, :name, :school_id, :group_category_id, :user_id, :member_ids, :private, :longitude, :latitude, :zipcode, :password, :image, :assets_attributes
  #acts_as_mappable :auto_geocode=>{:field=>:zipcode, :error_message=>'Could not geocode address'}
  # geocoded_by :full_street_address   # can also be an IP address
  
  reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address
  
  
  has_many :assets, :as => :imageable, :dependent => :destroy


  accepts_nested_attributes_for :assets
  has_many :memberships, :dependent => :destroy, :foreign_key => :group_id
  has_many :members,    :through => :memberships, :source => :member, :foreign_key => :member_id
  belongs_to :owner,    :class_name => "User", :foreign_key => :user_id
  belongs_to :group_category
  has_many :assignments
  belongs_to :school
  has_many :posts,      :through => :assignments
  
  validates :name, :presence => true
  
  def self.searchable_columns
    wanted_columns = ['name', 'created_at']
    self.column_names.select{ |column| wanted_columns.include?(column) }
  end
  def self.translated_searchable_columns
    columns = self.searchable_columns
    result = columns.map{ |column| [Group.human_attribute_name(column.to_sym), column] }
    result
  end

end
