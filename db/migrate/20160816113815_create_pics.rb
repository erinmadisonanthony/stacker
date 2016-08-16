class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.text :message

      t.timestamps null: false
    end
  end
end
