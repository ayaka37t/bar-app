class User < ActiveRecord::Base
  has_one :setting
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  def self.send_notifications
    self.select_target_users.each do |user|
      response = ApiAccess.api_get({:key => "9c3c43e05e884ef1204c9448ea8b6e7a37a745200b612fd2473654d92bebaa2b", :pref => user.setting.area, :budget => "01", :url => "http://bar.com", :pattern => "0"})
      if shop = Bar.extract_shop(response)
        email = Notifier.notice_email(user, shop)
        p email.body
      else
        "条件変えましょう的な"
#        Notifier.deliver_notice_email(user, shop)
#        logger.info "[Mail] send email to #{user.email}"
      end
    end
  end

  def self.select_target_users
    # TODO : 通知対象ユーザを返すようにすること
    self.all
  end

end
