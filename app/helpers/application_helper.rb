module ApplicationHelper
	
	def calcQ(exch,bid,last,quan)
		isBtc = exch.include?('BTC-')
		isUsd = exch.include?('USDT-')
		isEth = exch.include?('ETH-')

 		curr = exch.to_s.gsub('BTC-','').gsub('USDT-','').gsub('ETH-','')
		usd  = @markets["USDT-BTC"][:last]
		btc  = @markets["BTC-#{curr}"][:last]

		if isBtc
			btcBidTot = quan *  bid
			btcLasTot = quan *  last
			usdBidTot = usd  * btcBidTot
			usdLasTot = usd  * btcLasTot
		elsif isUsd
			btcBidTot = (quan *  bid) * (1/usd)
			btcLasTot = (quan *  last) * (1/usd)
			usdBidTot = usd  * btcBidTot
			usdLasTot = usd  * btcLasTot			
		end
		param =  "'#{curr}',#{fl(quan)},#{fl(usd)},#{fl(btc)},#{fl(btcBidTot)},"
		param += "#{fl(btcLasTot)},#{fl(usdBidTot)}"
		raw "<a  href=\"#\" onclick=\"return setCalc(#{param});\">#{fl(quan)}</a>"
	end

	def getticker(exch)
		return "no market" if @markets.nil?
		btc = @markets[exch][:last]
	end

	def gettickerVar(exch)
		return "no market" if @markets.nil?
		@markets[exch][:perc]
	end

	def displayCondition(order)
		return "-" if order[:condition]=="NONE"
		cond = order[:condition]
		cond.gsub!('GREATER_THAN','>=')
		cond+" "+fl(order[:condtarget])
	end

	def upOrDown(n)
		if n>0
			out = "<span style='color:green'> "
			out += "<i class='fa fa-arrow-up' aria-hidden='true'></i> "
			out += "%0.2f" % n + "%"
			out += '</span>'
		else
			out = "<span style='color:red'> "
			out += "<i class='fa fa-arrow-down' aria-hidden='true'></i> "
			out += "%0.2f" % n + "%"
			out += '</span>'
		end
		out.html_safe
	end

	def fl(n)
		return "0" if !n || n.zero?
		if n.abs < 0.000001
			"%1.7f" % n
		elsif n.abs < 0.001
			"%1.5f" % n
		elsif n.abs < 0.01
			"%1.5f" % n
		elsif n.abs < 0.9
			"%1.4f" % n
		else
			"%1.2f" % n
		end

	end

	def linkBxGraph(exc,type)
		if type =~ /SELL/
			raw "<a href='https://bittrex.com/Market/Index?MarketName=#{exc}' target='_blank' style='color:green'>#{exc}</a>"
		else
			raw "<a href='https://bittrex.com/Market/Index?MarketName=#{exc}' target='_blank' style='color:red'>#{exc}</a>"
		end
	end

end
