class SessionsController < ApplicationController
  def new; end

  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase

    if user && user.authenticate(session[:password])
      if user.activated?
        login_success user
      else
        not_activate
      end
    else
      login_fail
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_success user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end

  def login_fail
    flash.now[:danger] = t "error.login_fail"
    render :new
  end

  def not_activate
    flash[:warning] = t "users.not_active"
    redirect_to root_url
  end
end
