# https://goo.gl/1xkRYL (Unofficial V2 doc)

class Wallet < ApplicationRecord
	include Bittrexbot

	def self.getall
		x = json('account/getbalances')
		logger.info x
		x
	end

	def self.values
		results = {}
		wallet = self.getall
		wallet.each do |w|
			currency = {
				:currency => w["Currency"],
				:balance => w["Balance"],
				:available => w["Available"],
				:pending => w["Pending"]
			}
			results.store(w["Currency"],currency) if w["Balance"]>0
		end
		results
	end

	def self.ratio(currency,wallet,markets)
		btcusd   = markets["USDT-BTC"][:last]
		totalbtc = 0 
		totalusd = 0
		currValbtc = 0
		currValusd = 0
		wallet.each do |k,wal|
			balance    = wal[:balance]
			#btc        = markets["BTC-#{k}"]
			if k=="USDT"
				btc = 1/btcusd
			elsif k=="BTC"
				btc = 1
			else
				btc = markets["BTC-#{k}"][:last]
			end
			#logger.info "BALANCE #{currency} | #{k} --> \t #{balance} x #{btc}"
			valbtc     = balance * btc

			valusd 	   = valbtc * btcusd
			currValbtc = valbtc if currency =~ /#{k}/
			currValusd = valusd if currency =~ /#{k}/
			totalbtc  += valbtc
			totalusd  += valusd
		end
		#logger.info "-----------------------------"
		((currValusd/totalusd)*100).round
	end

	def self.valBtc(q,curr,markets)
		curr = curr.to_s.gsub('USDT-','').gsub('ETH-','').gsub('BTC-','')
		btcusd = markets["USDT-BTC"][:last]
		if curr=="USDT"
			btc = 1/btcusd
		elsif curr=="BTC"
			btc = 1
		else
			btc = markets["BTC-#{curr}"][:last]
		end
		btc * q
	end

	def self.valUsd(q,curr,markets)
		curr = curr.to_s.gsub('BTC-','').gsub('USDT-','').gsub('ETH-','')
		btcusd = markets["USDT-BTC"][:last]
		if curr=="USDT"
			btc = 1/btcusd
		elsif curr=="BTC"
			btc = 1   
		else
			btc = markets["BTC-#{curr}"][:last]
		end
		btc * q * btcusd
	end
end
