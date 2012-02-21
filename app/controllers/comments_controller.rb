class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    authorize! :manage, Comment
  end

  def create
    @comment.user = current_user
    if @comment.save
      redirect_to @comment.article, :notice => "Váš komentář byl úspěšně přijat."
    else
      redirect_to @comment.article
      # TODO: jak zde předat parametry a chybové hlášky zpět?
      # resp. jak správně vyvolat tuto metodu z ArticlesController#show ...
      # nebo jak s ní správně interagovat?
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to @comment.article, :notice  => "Komentář byl upraven."
    else
      render :action => 'edit'
    end
  end

  def destroy
    article = @comment.article
    @comment.destroy
    redirect_to article, :notice => "Komentář byl odstraněn."
  end
end
