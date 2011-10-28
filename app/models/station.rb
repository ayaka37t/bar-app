# -*- coding: utf-8 -*-
class Station < ActiveRecord::Base

  def self.search_pref(user)
    uri = URI.parse("http://www.ekidata.jp/api/n.php")
    uri.query = {"w" => user.setting.station}.to_query
    res = self.api_request(:get, uri.to_s)
    if res["ekidata"]["station"][0]
      sprintf("%02d", res["ekidata"]["station"][0]["pref_cd"])
    else
      sprintf("%02d", res["ekidata"]["station"]["pref_cd"])
    end
  end

  def self.search_station(params)
    uri = URI.parse("http://www.ekidata.jp/api/n.php")
    uri.query = {"w" => params}.to_query
    res = self.api_request(:get, uri.to_s)
    unless res["ekidata"]["station"].blank?
      case res["ekidata"]["station"].class.to_s
      when "Array"
        res["ekidata"]["station"].map {|record| record['station_name']}.uniq
      else
        res["ekidata"]["station"].station_name
      end
    else
      "ないです"
    end
  end


private
  def self.api_request method, uri
    response = HTTParty.send method, uri
    if response.code.to_s == "200"
      Hashie::Mash.new(response)
    else
      logger.info "[Unexpected status] ResponseCode:#{response.code} Detail:#{response.inspect}"
    end
  end

  def self.original_url
    "http://www.ekidata.jp/api/n.php"
  end

end
