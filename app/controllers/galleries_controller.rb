class GalleriesController < ApplicationController
  load_and_authorize_resource


  def index
    @galleries = @galleries.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @gallery.group = current_user.group
    @gallery.user_id = current_user.id
  end

  def create
    if @gallery.save
      redirect_to @gallery, :notice => "Successfully created gallery."
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
      redirect_to @gallery, :notice  => "Successfully updated gallery."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gallery.destroy
    redirect_to galleries_url, :notice => "Successfully destroyed gallery."
  end
end
