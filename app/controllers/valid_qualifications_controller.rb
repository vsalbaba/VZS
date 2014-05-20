# -*- encoding : utf-8 -*-
class ValidQualificationsController < ApplicationController
  def create
    @qualification = Qualification.find(params[:qualification_id])
    @valid_qualification = @qualification.valid_qualifications.build params[:valid_qualification]
    if @valid_qualification.save
      redirect_to @qualification, :notice => flash_message(:update, @qualification)
    else
      redirect_to @qualification, :notice => "Došlo k chybě."
    end
  end

  def edit
    @qualification = Qualification.find(params[:qualification_id])
    @valid_qualification = @qualification.valid_qualifications.find params[:id]
  end

  def update
    @qualification = Qualification.find(params[:qualification_id])
    @valid_qualification = @qualification.valid_qualification.find params[:id]
    if @valid_qualification.update_attributes params[:valid_qualification]
      redirect_to @qualification
    else
      render :action => "edit"
    end
  end
end