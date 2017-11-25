class CreateWallets < ActiveRecord::Migration[5.1]

  # id = attrs['Uuid'].to_s
  # address = attrs['CryptoAddress']
  # currency = attrs['Currency']
  # balance = attrs['Balance']
  # available = attrs['Available']
  # pending = attrs['Pending']
  # raw = attrs
  # requested = attrs['Requested']
  def change
  	create_table :wallets do |t|
  		t.string :uuid
  		t.string :address
  		t.string :currency
  		t.float :balance
  		t.float :available
  		t.float :pending
  		t.timestamps
  	end
  end
end
