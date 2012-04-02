class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def list
    @profiles = {
      :members => { :younger15 => [], :younger18 => [], :adults => [] },
      :outsiders => { :younger15 => [], :younger18 => [], :adults => [] }
    }
    Profile.all.each do |p|
      p p.first_name.to_s + p.second_name.to_s + p.user_age.to_s
      byage = :adults
      if p.user_age.to_i < 15
        byage = :younger15
      elsif p.user_age.to_i < 18
        byage = :younger18
      end

      if p.is_member_or_more?
        @profiles[:members][byage] << p
      else
        @profiles[:outsiders][byage] << p
      end
    end
    p @profiles
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      redirect_to @profile, :notice => "Successfully created profile."
    else
      render :action => 'new'
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      redirect_to @profile, :notice  => "Successfully updated profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to profiles_url, :notice => "Successfully destroyed profile."
  end
end
