class PhotosController < ApplicationController
  load_and_authorize_resource :except => :create

  def create
    result = { :status => true, :errors => nil }
    @photo = current_user.photos.new(params[:photo].merge(:gallery_id => params[:gallery_id]))

    authorize! :create, @photo

    if @photo.save
      if not request.xhr?
        redirect_to @photo.gallery, :notice => "Fotka byla úspěšně přiložena."
        return
      end
      result[:status] = true
    else
      if not request.xhr?
        @gallery = @photo.gallery
        render 'galleries/show'
        return
      end
      result[:status] = false
      result[:errors] = @photo.errors.messages
      p @photo.errors.messages
    end
    render :js => result.to_json
  end

  def edit
  end

  def update
    @photo.attributes = params[:photo]

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
