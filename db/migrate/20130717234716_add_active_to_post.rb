class AddActiveToPost < ActiveRecord::Migration
  def change
    add_column :posts, :active, :boolean, :default => true
  end
end
