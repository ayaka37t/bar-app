class Bar < ActiveRecord::Base
  def self.extract_probability response
    today = Date.today.strftime("%Y-%m-%d") 
    response.forecast.umbrella.umbrellaIndex.select{|rec| rec.date == today}.first.value
  end


  def self.notice? probability
    probability > 30
  end

  def self.extract_shop response
    count = response.shops.shop.count
    rand = rand(count)
    shop = response.shops.shop[rand]
  end

  def self.shop? shop
    shop
  end

end
