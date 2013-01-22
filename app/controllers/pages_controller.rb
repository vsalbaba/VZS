# -*- encoding : utf-8 -*-
class PagesController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pages }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @page }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end


  def create
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, :notice => flash_message(:create, @page) }
        format.json { render :json => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end
  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, :notice => flash_message(:update, @page) }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url, :notice => flash_message(:destroy, @page) }
      format.json { head :no_content }
    end
  end
end
