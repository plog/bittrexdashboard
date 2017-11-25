require 'daru/view'
class VisitorsController < ApplicationController

	def index
		Daru::View.plotting_library = :googlecharts
		@markets  = Market.getall
		@wallet   = Wallet.values
		@orders   = Order.getOrdersv2
		@history  = Order.getOrdersHistoryv2

		@orders.each do |k,order|
			exch 	 = order[:exchange]
			market 	 = {exch => @markets[exch]}
			@markets = @markets.except(exch)
			@markets = market.merge(@markets)
		end

		exch 	 = "USDT-BTC"
		market 	 = {exch => @markets[exch]}
		@markets = @markets.except(exch)
		@markets = market.merge(@markets)

		@wallet.each do |k,order|
			exch 	 = order[:currency]
			if exch == "BTC" || exch == "USDT"
				exch = "USDT-BTC"
			else
				exch = "BTC-#{exch}"
			end
			market 	 = {exch => @markets[exch]}
			@markets = @markets.except(exch)
			@markets = market.merge(@markets)
		end

	end

end
