class CreateOrderbooks < ActiveRecord::Migration[5.1]
	def change
		create_table :orderbooks do |t|
			t.string :name # market
			t.string :t # type
			t.float :q # quantity
			t.float :r # rate
			t.timestamps
		end
	end
end


