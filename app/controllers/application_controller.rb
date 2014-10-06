# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :current_profile
  helper_method :pages_for_menu
  helper_method :pages_for_navbar

  def welcome
    @articles = Article.approved.accessible_by(current_ability).order('sticky DESC, created_at DESC').limit(30)
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "MS VZS ČČK Třebíč"

    # the news items
    @news_items = Article.accessible_by(current_ability).order("created_at desc")

    # this will be our Feed's update timestamp
    @updated = @news_items.first.updated_at unless @news_items.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  private

  def flash_message(action, object)
    t action, :scope => [:flash, object.class.to_s.downcase]
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end

  def current_profile
    @current_user.profile
  end

  def pages_for_menu
    Page.find_all_by_menu(true)
  end

  def pages_for_navbar
    Page.find_all_by_navbar(true)
  end

end
