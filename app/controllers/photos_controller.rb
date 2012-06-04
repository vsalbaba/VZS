class PhotosController < ApplicationController
  load_and_authorize_resource :except => :create

  def create
    @photo = current_user.photos.new(params[:photo].merge(:gallery_id => params[:gallery_id]))
    authorize! :create, @photo

    if @photo.name.empty? and not @photo.file_name.empty?
      @photo.name = @photo.file_name
    end
    if @photo.save
      redirect_to @photo.gallery, :notice => "Fotka byla úspěšně přiložena."
    else
      @gallery = @photo.gallery
      render 'galleries/show'
    end
  end

  def edit
  end

  def update
    @photo.attributes = params[:photo]
    if @photo.name.empty?
      @photo.name = @photo.file_name
    end
    authorize! :update, @photo
    if @photo.save
      redirect_to @photo.gallery, :notice => 'Fotka přejmenována'
    else
      redirect_to @photo.gallery, :notice => 'Neplatné jméno fotky ...?'
    end
  end

  def destroy
    gallery = @photo.gallery
    @photo.destroy
    redirect_to gallery, :notice => "Fotka byla odstraněna."
  end
end
