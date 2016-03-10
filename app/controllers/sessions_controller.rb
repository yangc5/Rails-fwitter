class SessionsController < ApplicationController
  def new
  end

  def auth
    request.env['omniauth.auth']
  end

  def create
    if auth['uid']
      user = User.find_by(email: auth[:info][:email])
      if user.nil?
        user = User.create(name: auth[:info][:name], email: auth[:info][:email], password: "password")
      end
      log_in user
      redirect_to user
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to user
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
