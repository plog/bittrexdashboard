class CreateOrders < ActiveRecord::Migration[5.1]

  #id = attrs['Id'] || attrs['OrderUuid']
  #type = (attrs['Type'] || attrs['OrderType']).to_s.capitalize
  #exchange = attrs['Exchange']
  #quantity = attrs['Quantity']
  #remaining = attrs['QuantityRemaining']
  #price = attrs['Rate'] || attrs['Price']
  #total = attrs['Total']
  #fill = attrs['FillType']
  #limit = attrs['Limit']
  #commission = (attrs['Commission'] || attrs['CommissionPaid']).to_f
  #raw = attrs
  #opened_at = extract_timestamp(attrs['Opened'])
  #executed_at = extract_timestamp(attrs['TimeStamp'])
  #closed_at = extract_timestamp(attrs['Closed'])
  def change
    create_table :orders do |t|
      t.string :uuid
      t.string :type
      t.string :exchange
      t.float :quantity
      t.float :remaining
      t.float :price
      t.float :total
      t.string :fill
      t.float :limit
      t.float :commission
      t.datetime :opened_at
      t.datetime :executed_at
      t.datetime :closed_at
      t.timestamps
    end
  end
end
