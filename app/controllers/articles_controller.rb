class ArticlesController < ApplicationController
  load_and_authorize_resource


  def index
    @articles = @articles.paginate(:page => params[:page])
  end

  def show
    # FIXME: je vůbec přijatelné zde zakládat komentář?
    # není lepší zavolat metodu CommentsController#new apod?
    @comment = Comment.new
    @comment.article_id = @article.id
    @comment.user = current_user
  end

  def new
    @article.group_id = current_user.group.id
    @article.user_id = current_user.id
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
