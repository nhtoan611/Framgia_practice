class AccountActivationsController < ApplicationController
  private

  attr_reader :user

  public

  def edit
    @user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      active_success
    else
      flash[:danger] = t "users.active_fail"
      redirect_to root_url
    end
  end

  def active_success
    user.activate
    log_in user
    flash[:success] = t "users.active_success"
    redirect_to user
  end
end
