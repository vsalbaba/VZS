class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  before_filter :authorize_update, :except => [:new, :create, :index, :show]

  def index
    authorize! :read_members, User
    @users = {}

    users = User.joins(:profile).order('birthdate DESC').group_by(&:is_member_or_more?)
    @users[:members] = users[true].group_by { |u| u.profile.user_age_group } unless users[true].nil?
    @users[:outsiders] = users[false].group_by { |u| u.profile.user_age_group } unless users[false].nil?
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
    # adresa je nepovinna ale chceme ji mit alespon prazdnou
    @user.profile.build_address unless @user.profile.address 
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

  def authorize_update
    authorize! :update, @user
  end

  def find_user
    @user = User.find(params[:id])
  end
end
