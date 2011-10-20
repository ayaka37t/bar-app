# -*- coding: utf-8 -*-
class Station < ActiveRecord::Base

  def self.search_pref(user)
    uri = URI.parse("http://www.ekidata.jp/api/n.php")
    uri.query = {"w" => user.setting.area}.to_query
    res = self.api_request(:get, uri.to_s)
    if res["ekidata"]["station"][0]
      sprintf("%02d", res["ekidata"]["station"][0]["pref_cd"])
    else
      sprintf("%02d", res["ekidata"]["station"]["pref_cd"])
    end
  end

#      prefecture = sprintf("%02d", res["ekidata"]["station"][0]["pref_cd"])
#    Setting.prefecture_index_show(prefecture)

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
