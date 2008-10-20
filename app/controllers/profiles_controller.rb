class ProfilesController < ApplicationController
  before_filter :login_required

  # GET /profiles
  # GET /profiles.xml
  def index
    @profiles = Profile.find(:all)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @childrens }
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
    @profile.contact_info = ContactInfo.new(params[:contact_info].merge(:profile => @profile))
    if @profile.save
      flash[:notice] = "Profile was successfully crreated."
      redirect_to profiles_url
    else
      render :action => :new
    end
  end

  def new
    @profile = Profile.new(:user_id => current_user.id)
    @profile.contact_info = ContactInfo.new(:profile => @profile)
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    params[:profile][:existing_high_school_attendance_attributes] ||= {}
    params[:profile][:existing_college_attendance_attributes] ||= {}
    params[:profile][:existing_employment_attributes] ||= {}
    params[:contact_info][:existing_email_address_attributes] ||= {}

    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile]) && @profile.contact_info.update_attributes(params[:contact_info])
      flash[:notice] = "Successfully updated profile"
      redirect_to profile_path(@profile)
    else
      render :action => :edit
    end
  end
end
