class CreateHistories < ActiveRecord::Migration[5.1]

  def change
    create_table :histories do |t|
      t.string :name
      t.float :o
      t.float :h
      t.float :l
      t.float :c
      t.float :bv
      t.datetime :t
      t.timestamps
    end
  end
  
end
