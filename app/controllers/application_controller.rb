class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # need to make user signed in user available to all controllers

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def authorize
    redirect_to new_session_path, alert: 'Please Sign In or Sign Up!' if current_user.nil?
  end

  def admin_authorize
    redirect_to new_session_path, 
    alert: "Only for Admin!" unless current_user.admin
  end

end
