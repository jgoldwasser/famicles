class ArrivalsController < ApplicationController
  before_filter :login_required, :load_child

  # GET /arrivals/1
  # GET /arrivals/1.xml
  def show
    @arrival = Arrival.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @arrival }
    end
  end

  # GET /famicles/:famicle_id/children/new
  def new
    @arrival = Arrival.new(:child => @child)
  end

  def edit
    @arrival = Arrival.find(params[:id])
  end

  def create
    @arrival = Arrival.new(params[:arrival])

    if @arrival.save
      flash[:notice] = "arrival was successfully crreated."
      redirect_to famicle_child_path(@child.famicle, @child)
    else
      render :action => :new
    end
  end

  def update
    @arrival = Arrival.find(params[:id])
    if @arrival.update_attributes(params[:arrival])
      flash[:notice] = "Successfully updated pre arrival info"
      redirect_to famicle_child_path(@child.famicle, @child)
    else
      render :action => :edit
    end
  end

private
  def load_child
    @child = Child.find(params[:child_id])
  end

  def set_current_tab
    @current_tab = 'children'
  end
end
