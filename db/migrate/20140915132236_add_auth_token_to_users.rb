class AddAuthTokenToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :auth_token
    end

    add_index  :users, :auth_token, :unique => true
  end

  def self.down
    remove_column :users, :auth_token
  end
end
