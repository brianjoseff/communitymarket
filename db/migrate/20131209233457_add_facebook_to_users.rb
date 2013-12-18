class AddFacebookToUsers < ActiveRecord::Migration
  def change
    unless column_exists? :users, :uid
      add_column :users, :uid, :string
    end
    unless column_exists? :users, :provider
      add_column :users, :provider, :string
    end
    unless column_exists? :users, :oauth_token
      add_column :users, :oauth_token, :string
    end
    unless column_exists? :users, :oauth_expires_at
      add_column :users, :oauth_expires_at, :datetime
    end
    

    
  end
end
