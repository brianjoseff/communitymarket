class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :post_id
      t.integer :group_id

      t.timestamps
    end
  end
end
