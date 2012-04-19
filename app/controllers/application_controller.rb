class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def welcome
    @articles = Article.accessible_by(current_ability).order('created_at DESC').limit(10)
  end

  private
  def current_user_session
	  return @current_user_session if defined?(@current_user_session)
	  @current_user_session = UserSession.find
  end

  def current_user
	  @current_user = current_user_session && current_user_session.record
  end

end
