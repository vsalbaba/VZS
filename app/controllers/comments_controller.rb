# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController
  load_and_authorize_resource :except => :create

  def index
    authorize! :manage, Comment
  end

  def create
    authorize! :create, Comment

    @comment = current_user.comments.new(params[:comment].merge(:article_id => params[:article_id]))

    if @comment.save
      redirect_to @comment.article, :notice => flash_message(:create,@comment)
    else
      @article = @comment.article
      render 'articles/show'
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to @comment.article, :notice  => flash_message(:update, @comment)
    else
      render :action => 'edit'
    end
  end

  def destroy
    article = @comment.article
    @comment.destroy
    redirect_to article, :notice => flash_message(:destroy, @comment)
  end
end
