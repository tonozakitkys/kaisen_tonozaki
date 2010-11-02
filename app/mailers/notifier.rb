class Notifier < ActionMailer::Base
  default :from => "kai1000_rails_test@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.ordered.subject
  #
  def ordered(order)
    @greeting = "Hi"
    @order = order

    mail :to => @order.email, :cc => "sdfae@ewsa.eas.dfeafa", :subject => "ご注文ありがとうございます。"
  end
end
