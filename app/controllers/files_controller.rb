class FilesController < ApplicationController
  def index
    @files = Attachment.all
  end

  def new
    @file = Attachment.new
  end

  def create
    @file = current_user.attachments.new params[:attachment]

    if @file.save!
      redirect_to files_path, :notice => flash_message(:create, @file)
    else
      render :new
    end
  end
end
