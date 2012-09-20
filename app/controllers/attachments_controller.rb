class AttachmentsController < ApplicationController
  load_and_authorize_resource :except => :create

  def create
    @attachment = current_user.attachments.new(params[:attachment].merge(:article_id => params[:article_id]))
    authorize! :create, @attachment

    if @attachment.save
      redirect_to @attachment.article, :notice => flash_message(:create, @attachment)
    else
      @article = @attachment.article
      render 'articles/show'
    end
  end

  def destroy
    article = @attachment.article
    @attachment.destroy
    redirect_to article, :notice => flash_message(:destroy, @attachment)
  end
end
