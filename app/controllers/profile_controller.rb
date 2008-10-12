class ProfileController < ApplicationController

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
    @profile = Profile.new
  end
end
