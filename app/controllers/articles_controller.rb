class ArticlesController < ApplicationController
  load_and_authorize_resource


  def index
    @articles = @articles.paginate(:page => params[:page])
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
      redirect_to @article, :notice => "Successfully created article."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @article.attributes = params[:article]
    authorize! :update, @article
    if @article.save
      redirect_to @article, :notice  => "Successfully updated article."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, :notice => "Successfully destroyed article."
  end
end
