class ChangeOrderType < ActiveRecord::Migration[5.1]
  def change
  	rename_column :orders, :type, :ordertype
  end
end
