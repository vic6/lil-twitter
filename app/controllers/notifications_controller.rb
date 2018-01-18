class NotificationsController < ApplicationController
  def send_message
    @twilio_number = ENV['TWILIO_NUMBER']
    @my_number = ENV['PHONE_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.messages.create(from: @twilio_number,
                            to: @my_number,
                            body: current_user.name + ' just signed up!',
                            media_url: 'https://vignette.wikia.nocookie.net/spongebob/images/8/8e/Spongebob-rainbow-meme-990x557.jpg/revision/latest/scale-to-width-down/640?cb=20170731020011')
    redirect_to user_path(current_user)
  end

  def index
  end
end
