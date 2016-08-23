class AddPhotoToPics < ActiveRecord::Migration
  def change
    add_column :pics, :photo, :string
  end
end
