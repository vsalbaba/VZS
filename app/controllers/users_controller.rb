class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    authorize! :read_members, User
    @users = {}

    users = User.joins(:profile).order('birthdate DESC').group_by(&:is_member_or_more?)
    @users[:members] = users[true].group_by { |u| u.profile.user_age_group } unless users[true].nil?
    @users[:outsiders] = users[false].group_by { |u| u.profile.user_age_group } unless users[false].nil?
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
       redirect_to root_url, :notice => 'Registrace úspěšně dokončna'
    else
      render :action => 'new'
    end
  end

  def edit
  end


  def update
    @user.attributes = params[:user]
    authorize! :save, @user
    if @user.save
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end
  
  protected

  def find_user
    @user = User.find(params[:id])
  end
end
