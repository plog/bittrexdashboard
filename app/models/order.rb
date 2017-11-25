# https://goo.gl/1xkRYL (Unofficial V2 doc)

class Order < ApplicationRecord

	def self.getall
		json('account/getorderhistory')
	end

	def self.getOrdersv2
		results = {}
		orders = jsonv2('/key/orders/getopenorders')
		orders.each do |o|
			order = {
				:uuid 			=> o["Uuid"],
				:orderuuid 		=> o["OrderUuid"],
				:bittrexid 		=> o["Id"],
				:ordertype 		=> o["OrderType"].to_s,
				:exchange 		=> o["Exchange"],
				:quantity 		=> o["Quantity"],
				:remaining 		=> o["QuantityRemaining"],
				:price 			=> o["Price"],
				:priceperunit 	=> o["PricePerUnit"],
				:isopen 		=> o["IsOpen"],
				:cancelinitiated=> o["CancelInitiated"],
				:total 			=> 0,
				:fill 			=> "",
				:limit 			=> o["Limit"],
				:commission 	=> o["CommissionPaid"],
				:opened_at 		=> o["Opened"],
				:executed_at 	=> o["Closed"],
				:condtarget 	=> o["ConditionTarget"],
				:immediate 		=> o["ImmediateOrCancel"],
				:closed_at 		=> o["Closed"],
				:updated_at 	=> o["Updated"],
				:conditional 	=> o["IsConditional"],
				:condition 		=> o["Condition"]
			}
			results.store(o["Opened"],order) 
			dbOrder = Order.new(order).save if !Order.exists?(orderuuid: o["OrderUuid"])
		end
		results

	end

	def self.getOrdersHistoryv2
		results = {}
		orders = jsonv2('/key/orders/getorderhistory')
		orders.each do |o|
			order = {
				:exchange 		=> o["Exchange"],
				:timestamp 		=> o["TimeStamp"],
				:closed 		=> o["Closed"],
				:type 			=> o["OrderType"],
				:limit 			=> o["Limit"],
				:quatity 		=> o["Quantity"],
				:remaining 		=> o["QuantityRemaining"],
				:commission 	=> o["Commission"],
				:conditional 	=> o["IsConditional"],
				:condition 		=> o["Condition"],
				:condtarget 	=> o["ConditionTarget"],
				:immediate 		=> o["ImmediateOrCancel"],
			}
			results.store(o["TimeStamp"],order) 
		end
		results
	end
end
