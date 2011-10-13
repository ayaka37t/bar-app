class Notifier < ActionMailer::Base
  default :from => "any_from_address@example.com"

  def notice_email(user, shop)
    subject = "本日のbar情報"
    body = "今日のおすすめは#{shop.type}の#{shop.name}★　→#{shop.url_mobile}#{shop.address}"
    mail(:to => user.email, :subject => subject, :body => body)
    #mail → putsでいける。かも。
  end

end
