class Market < ApplicationRecord
	include Bittrexbot

	def self.getall
		Rails.cache.fetch :Marketgetall, cache_nils: false, :expires_in => 1.minutes do
			results = {}

			longNames = json('public/getmarkets')

			markets   = json('public/getmarketsummaries')
			markets.each do |m|
				mname = m["MarketName"]
				last  = m["Last"]
				prev  = m["PrevDay"]
				perc  = ((last/prev)*100)-100
				mark  = {
					:name => mname,
					:last => m["Last"],
					:prevday => m["PrevDay"],
					:perc => perc.to_f,
					:namelong => self.getLongname(mname,longNames)
				}
				results.store(m["MarketName"],mark)
			end
			results
		end
	end

	def self.getLongname(exch,longNames)
		exch = exch.to_s.gsub('BTC-','').gsub('USDT-','').gsub('ETH-','')
		longNames.each do |m|
			if m["MarketCurrency"] == exch
				return m["MarketCurrencyLong"]
			end
		end
		return ""
	end

	#https://bittrex.com/Api/v2.0/pub/market/GetTicks?marketName=BTC-WAVES&tickInterval=oneMin&_=1511077498397
end
