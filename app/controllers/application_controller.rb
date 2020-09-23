class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    return flash[:danger] = 'You must be logged in to perform that action' unless logged_in?
  end

  def require_admin
    flash[:danger] = 'Only admins can perform that action' if !logged_in? || (logged_in? and !current_user.admin?)
  end

  def require_same_user
    return flash[:danger] = 'You can only edit or delete your own articles' unless current_user == @article.user
  end
end
