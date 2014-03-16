class FilesController < ApplicationController
  def index
    authorize! :see, "files"
    @files = Attachment.all
  end

  def new
    authorize! :upload, "files"
    @file = Attachment.new
  end

  def create
    authorize! :upload, "files"
    @file = current_user.attachments.new params[:attachment]

    if @file.save!
      redirect_to files_path, :notice => flash_message(:create, @file)
    else
      render :new
    end
  end
end
