require 'faraday'
require 'base64'
require 'json'

# https://goo.gl/1xkRYL (Unofficial V2 doc)

class ApplicationRecord < ActiveRecord::Base
  HOST    = 'https://bittrex.com/api/v1.1'
  HOSTV2  = 'https://bittrex.com/Api/v2.0'
  KEY     = Rails.application.secrets.bittrex_api_key
  SEC     = Rails.application.secrets.bittrex_api_secret
  DEMO    = 0.2

  self.abstract_class = true

  def self.json(path, params = {}, headers = {})
    Rails.cache.fetch "json#{path}#{params}#{KEY}", :expires_in => 5.minutes do
      nonce = Time.now.to_i
      response = conn.get do |req|
        url = "#{HOST}/#{path}"
        req.params.merge!(params)
        req.url(url)
        req.params[:apikey]    = KEY
        req.params[:nonce]     = nonce
        req.headers["apisign"] = sign(url, nonce)
      end
      res = JSON.parse(response.body)['result']
      if res.nil? and JSON.parse(response.body)["message"]
        raise Exception.new("ERROR: #{path} : " + JSON.parse(response.body)["message"] + ": " + params.to_s)
      end
      res
    end
  end

  def self.jsonv2(path, params = {}, headers = {})
    Rails.cache.fetch "jsonv2#{path}#{params}#{KEY}", :expires_in => 5.minutes do
      nonce            = Time.now.to_i
      url              = "#{HOSTV2}#{path}?apikey=#{KEY}&nonce=#{nonce}"
      uri              = URI(url)
      signature        = OpenSSL::HMAC.hexdigest('sha512',SEC,url)
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      header   = {"Content-Type"=>"application/json","nonce"=>nonce.to_s,"apikey"=> KEY,"apisign"=> signature}
      req      = Net::HTTP::Post.new(url)
      req.initialize_http_header(header).to_json
      req.body = JSON.dump(params)
      res      = http.request(req)
      out = JSON.parse(res.body)['result']
      if res.nil? and JSON.parse(res.body)["message"]
        raise Exception.new("ERROR: #{path} : " + JSON.parse(res.body)["message"] + ": " + params.to_s)
      end
      out
    end
  end


  private
  def self.sign(url, nonce)
    api_secret = KEY
    OpenSSL::HMAC.hexdigest('sha512', SEC, "#{url}?apikey=#{api_secret}&nonce=#{nonce}")
  end

  def self.conn
    @connection ||= Faraday.new(:url => HOST) do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end
  end

end
