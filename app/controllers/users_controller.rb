class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    authorize! :read_members, User
    @presenter = ProfilePresenters::IndexPresenter.new
  end

  def show
    authorize! :read, @user
  end

  def new
    @user = User.new
    @user.build_profile
    @user.profile.build_address
    authorize! :create, @user
  end

  def create
    @user = User.new(params[:user])
    # adresa je nepovinna ale chceme ji mit alespon prazdnou
    @user.profile.build_address unless @user.profile.address 
    authorize! :create, @user
    if @user.save
       redirect_to root_url, :notice => flash_message(:create, @user)
    else
      render :action => 'new'
    end
  end

  def edit
    authorize! :update, @user
  end


  def update
    @user.attributes = params[:user]
    authorize! :save, @user
    if @user.save
      redirect_to @user, :notice  => flash_message(:update, @user)
    else
      render :action => 'edit'
    end
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    redirect_to users_url, :notice => flash_message(:destroy, @user)
  end
  
  protected

  def find_user
    @user = User.find(params[:id])
  end
end
