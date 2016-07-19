class AlterItemsAddOrder < ActiveRecord::Migration
  def change
    add_column :items, :order, :integer
    add_index :items, :order
  end
end
