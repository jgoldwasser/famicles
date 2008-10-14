class ProfilesController < ApplicationController
  before_filter :login_required
  
  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      flash[:notice] = "Profile was successfully crreated."
      redirect_to profiles_url
    else
      render :action => :new
    end
  end

  def new
    @profile = Profile.new(:user_id => current_user.id)
    @profile.high_school_attendances.build
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    params[:profile][:existing_high_school_attendance_attributes] ||= {}

    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Successfully updated profile and high schools"
      redirect_to_profile_path(@profile)
    else
      render :action => :edit
    end
  end
end
