class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.string :subject
      t.string :sender
      t.string :recipient
      t.integer :post_id

      t.timestamps
    end
  end
end
