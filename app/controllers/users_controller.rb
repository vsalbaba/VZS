class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    @user.build_profile
    @user.profile.build_address
  end

  def create
    @user = User.new(params[:user])
    if @user.save
       redirect_to root_url, :notice => 'Registrace úspěšně dokončna'
    else
      render :action => 'new'
    end
  end

  def edit
  end


  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end
  
  protected
  def find_user
    @user = User.find(params[:id])
  end
end
