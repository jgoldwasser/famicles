class ProfilesController < ApplicationController
  before_filter :login_required

  # GET /profiles
  # GET /profiles.xml
  def index
    @profiles = Profile.find(:all)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @famicles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @profile }
    end
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      flash[:notice] = "Profile was successfully crreated."
      redirect_to create_famicle_url
    else
      render :action => :new
    end
  end

  def new
    @profile = Profile.new(:user_id => current_user.id, :public => ApplicationController::PUBLIC)
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    params[:profile][:existing_high_school_attendance_attributes] ||= {}
    params[:profile][:existing_college_attendance_attributes] ||= {}
    params[:profile][:existing_employment_attributes] ||= {}
    params[:profile][:contact_info_data][:existing_email_address_attributes] ||= {}

    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Successfully updated profile"
      redirect_to profile_path(@profile)
    else
      render :action => :edit
    end
  end
end
