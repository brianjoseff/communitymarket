class AddSchoolToPostAndUser < ActiveRecord::Migration
  def change
    add_column :posts, :school_id, :integer
    add_column :users, :school_id, :integer
  end
end
