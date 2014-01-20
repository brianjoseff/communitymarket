class AddCompletedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :completed, :boolean, :default => false
  end
end
