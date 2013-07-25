# -*- encoding : utf-8 -*-
class PhotosController < ApplicationController
  load_and_authorize_resource :except => [:create]

  def create
    result = { :status => true, :errors => nil }
    @photo = current_user.photos.new(params[:photo].merge(:gallery_id => params[:gallery_id]))

    authorize! :create, @photo

    if @photo.save
      if not request.xhr?
        redirect_to @photo.gallery, :notice => flash_message(:create, @photo)
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

  def sort
    params[:photo].each_with_index do |id, index|
      Photo.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  def update
    @photo.attributes = params[:photo]

    authorize! :update, @photo

    if @photo.save
      redirect_to @photo.gallery, :notice => flash_message(:update, @photo)
    else
      redirect_to @photo.gallery, :error => 'Neplatné jméno fotky ...?'
    end
  end

  def destroy
    gallery = @photo.gallery
    @photo.destroy
    redirect_to gallery, :notice => flash_message(:destroy, @photo)
  end
end
