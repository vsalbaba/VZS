class GalleriesController < ApplicationController
  load_and_authorize_resource


  def index
    @galleries = @galleries.order('created_at DESC').paginate(:page => params[:page])
  end

  def show
  end

  def new
    @gallery.group = current_user.group
    @gallery.user_id = current_user.id
    if params[:article]
      @gallery.article = Article.find_by_id(params[:article].to_i)
    end
  end

  def create
    if @gallery.save
      redirect_to @gallery, :notice => flash_message(:create, @gallery)
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @gallery.attributes = params[:gallery]
    authorize! :update, @gallery
    if @gallery.save
      redirect_to @gallery, :notice  => flash_message(:update, @gallery)
    else
      render :action => 'edit', :notice => flash_message(:error, @gallery)
    end
  end

  def destroy
    @gallery.destroy
    redirect_to galleries_url, :notice => flash_message(:destroy, @gallery)
  end
end
