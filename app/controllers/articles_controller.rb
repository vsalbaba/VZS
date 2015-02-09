# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  load_and_authorize_resource

  def index
    @articles = @articles.order('sticky DESC, created_at DESC')
  end

  def pending
    @articles = Article.pending.order('created_at DESC').paginate(:page => params[:page])
    render :action => 'index'
  end

  def show
  end

  def new
    @article.group = current_user.group
    @article.user_id = current_user.id
    @article.commentable = true
  end

  def create
    if @article.save
      redirect_to @article, :notice => flash_message(:create, @article)
    else
      render :action => 'new'
    end
  end

  def touch
    @article = Article.find params[:id]
    @article.touch
    if @article.save
      redirect_to @article, :notice => "Článek jako by byl vytvořen právě teď"
    else
      render :action => 'edit'
    end
  end

  def edit
  end

  def update
    @article.attributes = params[:article]
    authorize! :update, @article
    if @article.save
      redirect_to @article, :notice  => flash_message(:update, @article)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, :notice => flash_message(:destroy, @article)
  end
end
