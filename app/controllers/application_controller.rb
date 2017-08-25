class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  private

  def go_to_index_if_signed_in
    if logged_in? && params[:action] == 'new'
      redirect_to cats_url
    end
  end

  def require_logged_in
    redirect_to new_session_url if !logged_in? &&
    !["index","show"].include?(params[:action])
  end
  def require_logged_out

  end


end
