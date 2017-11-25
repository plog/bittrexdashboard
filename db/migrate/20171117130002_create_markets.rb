class CreateMarkets < ActiveRecord::Migration[5.1]
  # name          = 'MarketName'
  # currency      = 'MarketCurrency'
  # base 			    = 'BaseCurrency'
  # currency_name = 'MarketCurrencyLong'
  # base_name 		= 'BaseCurrencyLong'
  # minimum_trade = 'MinTradeSize'
  # active 			  = 'IsActive'
  def change
    create_table :markets do |t|
      t.string :name
      t.string :currency
      t.string :base
      t.string :currency_name
      t.string :base_name
      t.float :minimum_trade
      t.boolean :active
      t.timestamps
    end
  end
end
