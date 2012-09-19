class UsersController < ApplicationController
  before_filter :find_user, :only => [:stats, :show, :edit, :update, :destroy]

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
       redirect_to root_url, :notice => 'Registrace úspěšně dokončna'
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
  
  def stats
    #FIXME: authorize! ??
    @from_date = parse_date(params[:from_date])
    @to_date = parse_date(params[:to_date]) || Date.current
    @statistic = Statistic.new @user, :from => @from_date, :to => @to_date
    @shows = @statistic.shows
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end

  private

  def parse_date datestring
     Date.strptime(datestring, '%d. %m. %Y') if datestring.present?
  end
end
