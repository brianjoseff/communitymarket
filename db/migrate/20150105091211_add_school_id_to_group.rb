class AddSchoolIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :school_id, :integer
  end
end
