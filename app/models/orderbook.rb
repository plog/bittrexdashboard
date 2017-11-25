class Orderbook < ApplicationRecord

	def self.getall(market)
		results = {}
		dtnow  = DateTime.now
		orders = json('public/getorderbook',{market: market, type: "both"})
		sql = "DELETE FROM orderbooks WHERE name='#{market}'"
		ActiveRecord::Base.connection.execute(sql)

		orders.each do |k,order|
			order.each do |buysell|
				if !buysell.nil?
					x={name=>market,:t=>k,:q=>buysell["Quantity"],:r=>buysell["Rate"]}
					sql =  "INSERT INTO orderbooks(name,t,q,r,created_at,updated_at) VALUES "
					sql += "('#{market}','#{k}',#{buysell["Quantity"]},#{buysell["Rate"]},'#{dtnow}','#{dtnow}')"
					ActiveRecord::Base.connection.execute(sql)
				end
			end
		end
		results
	end


	def self.getboundaries(market)
		orders = json('public/getorderbook',{market: market, type: "both"})

		i=0
		tot=0
		size = orders["buy"].size * 0.80
		orders["buy"][0..size].each do |order|
			tot +=order["Rate"]
			i+=1
		end		
		buy = tot/i

		i=0
		tot=0
		orders["sell"][0..size].each do |order|
			tot +=order["Rate"]
			i+=1
		end		
		sell = tot/i

		{sell: sell, buy: buy}
	end

end
