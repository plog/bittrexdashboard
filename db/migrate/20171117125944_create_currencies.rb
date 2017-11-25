class CreateCurrencies < ActiveRecord::Migration[5.1]
  # name = attrs['CurrencyLong']
  # abbreviation = attrs['Currency']
  # transaction_fee = attrs['TxFee']
  # minimum_confirmation = attrs['MinConfirmation']
  # active = attrs['IsActive']
  # raw = attrs
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :abbreviation
      t.float :transaction_fee
      t.integer :minimum_confirmation
      t.boolean :active
      t.timestamps
    end
  end

end
