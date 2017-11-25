class CompleteOrder4 < ActiveRecord::Migration[5.1]
  def change
  	remove_column :orders, :conditional, :string
  	remove_column :orders, :condition,  :boolean

	add_column :orders, :conditional,:boolean
  	add_column :orders, :condition,  :string
  end
end
