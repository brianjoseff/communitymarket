class CreateEmailSettings < ActiveRecord::Migration
  def change
    create_table :email_settings do |t|
      t.string :name

      t.timestamps
    end
  end
end
