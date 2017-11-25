class CompleteOrder2 < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :orderuuid, :string
  	add_column :orders, :bittrexid, :integer
  	add_column :orders, :priceperunit, :float
  	add_column :orders, :isopen, :boolean
  	add_column :orders, :cancelinitiated, :boolean
  end
end
