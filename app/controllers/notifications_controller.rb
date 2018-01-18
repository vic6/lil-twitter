class NotificationsController < ApplicationController
  def send_message
    @twilio_number = '4158497322'
    p @twilio_number
    @my_number = ENV['PHONE_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create(from: @twilio_number,
                                    to: @my_number,
                                    body: current_user.name + ' just signed up!',
                                    media_url: 'http://i.imgur.com/NQqAhsK.jpg')
    redirect_to user_path(current_user)
  end

  def index
  end
end
