class AddVToHistory < ActiveRecord::Migration[5.1]
  def change
  	add_column :histories, :v, :float
  end
end
