class CompleteOrder3 < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :conditional, :string
  	add_column :orders, :condition, :boolean
  	add_column :orders, :condtarget, :float
  	add_column :orders, :immediate, :boolean
  	remove_column :orders, :bittrexid, :integer
  	add_column :orders, :bittrexid, :bigint
  end
end
