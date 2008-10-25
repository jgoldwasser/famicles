class FamiclesController < ApplicationController
  before_filter :login_required

  # GET /famicles
  # GET /famicles.xml
  def index
    @famicles = Famicle.find(:all)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @famicles }
    end
  end

  def new
    @famicle = Famicle.new
  end

  def create
    @famicle = Famicle.new(params[:famicle])

    if current_user.famicle_memberships.create!(:famicle => @famicle, :role => "creator", :default => true)
      flash[:notice] = "Famicle was successfully crreated."
      redirect_to famicles_url
    else
      render :action => :new
    end
  end
end
