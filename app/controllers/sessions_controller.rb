class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to(user)
    else
      # flash.now dissapears as soon as there is an additional request
      flash.now[:danger] = 'Incorrect email/password: Self-destruct initiated'
      render 'new'
    end
  end

  def destroy
  end
end
