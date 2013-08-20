class AddEmailSettingIdToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :email_setting_id, :integer
  end
end
