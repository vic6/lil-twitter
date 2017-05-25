class NotificationsController < ApplicationController
  def send_message
    @twilio_number = ENV['TWILIO_NUMBER']
    @my_number = ENV['PHONE_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create(from: @twilio_number,
                                    to: '7028398971',
                                    body: 'Time for some Ranch',
                                    media_url: 'http://i.imgur.com/NQqAhsK.jpg')
    redirect_to user_path(current_user)
  end

  def index
  end
end
