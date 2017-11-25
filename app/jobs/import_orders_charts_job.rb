# http://bica.co/2015/03/08/howto-using-activejob-with-delayedjob/
# $ rake jobs:work

class ImportOrdersChartsJob < ActiveJob::Base
	queue_as :default

	def perform(*args)
		orders = Order.all
		ActiveJob::Base.logger.info "Importing #{orders.size} Orders\n"

		orders.each do |order|
			callTicker(order.exchange,order.opened_at-1.day)
			callTicker(order.exchange,order.opened_at)
			callTicker(order.exchange,order.opened_at+1.day)
		end
	end

	def callTicker(exc,date)
		markets = History.jsonv2('/pub/market/GetTicks',{:marketName => exc,:tickInterval => "thirtyMin",:_ => date})
		markets.each{|ticker| insertHistory(exc,ticker)}
	end

	def insertHistory(exc,ticker)
		dtnow  = DateTime.now
		hm = {:name => exc}
		ticker.each{|k,v| hm.merge!({k.downcase.to_sym => v})}
		if !History.find_by(name: exc, t: hm[:t])
			ActiveJob::Base.logger.info "Inseeeeerrrttt #{hm}"
			sql =  "INSERT INTO histories(name,o,h,l,c,bv,t,created_at,updated_at) VALUES "
			sql += "('#{hm[:name]}',#{hm[:o]},#{hm[:h]},#{hm[:l]},#{hm[:c]},#{hm[:bv]},'#{hm[:t]}','#{dtnow}','#{dtnow}')"
			ActiveRecord::Base.connection.execute(sql)
			ActiveJob::Base.logger.info "INSERT: #{hm[:t]} #{hm[:name]}"
		else
			ActiveJob::Base.logger.info "Already exists: #{hm[:t]} #{hm[:name]}"
		end
	end
end
