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

  # GET /famicles/1
  # GET /famicles/1.xml
  def show
    @famicle = Famicle.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @famicle }
    end
  end

  def new
    @famicle = Famicle.new
  end

  def edit
    @famicle = Famicle.find(params[:id])
  end

  def create
    @famicle = Famicle.new(params[:famicle])

    if @famicle.save && current_user.famicle_memberships.create!(:famicle => @famicle, :role => "creator", :default => true)
      flash[:notice] = "Famicle was successfully crreated."
      redirect_to famicle_path(@famicle)
    else
      render :action => :new
    end
  end

  def update
    @famicle = Famicle.find(params[:id])
    if @famicle.update_attributes(params[:famicle])
      flash[:notice] = "Successfully updated famicle"
      redirect_to famicle_path(@famicle)
    else
      render :action => :edit
    end
  end
end
