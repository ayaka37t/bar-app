class Bar < ActiveRecord::Base

  def self.extract_shop response
    count = response.shops.shop.count
    rand = rand(count)
    shop = response.shops.shop[rand]
  end

  def self.shop? shop
    shop
  end

end
