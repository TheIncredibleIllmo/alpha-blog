class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    #one option or the other
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #!! transforms the result in a boolean
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
