class EmailSetting < ActiveRecord::Base
  # these are the daily, weekly, per-post, or never email update settings
  # that users can set on a per-group basis
  
  
  attr_accessible :name
end
