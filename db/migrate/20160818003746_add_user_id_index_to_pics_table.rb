class AddUserIdIndexToPicsTable < ActiveRecord::Migration
  def change
    add_index :pics, :user_id
  end
end
