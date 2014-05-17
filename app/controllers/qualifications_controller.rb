class QualificationsController < ApplicationController

  def index
    @qualifications = Qualification.order('abbreviation DESC').paginate(:page => params[:page])
  end

  def show
    @qualification = Qualification.find(params[:id])
  end

  def new
    @qualification = Qualification.new params[:qualification]
  end

  def edit
    @qualification = Qualification.find(params[:id])
  end

  def update
    @qualification = Qualification.find(params[:id])
    if @qualification.update_attributes(params[:qualification])
      redirect_to @qualification, :notice => flash_message(:update, @qualification)
    else
      render :action => 'edit'
    end
  end

  def create
    @qualification = Qualification.new params[:qualification]
    if @qualification.save
      redirect_to @qualification, :notice => flash_message(:create, @qualification)
    else
      render :action => 'new'
    end
  end
end
