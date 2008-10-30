class PrearrivalsController < ApplicationController
  before_filter :login_required, :load_child

  # GET /prearrivals/1
  # GET /prearrivals/1.xml
  def show
    @prearrival = Prearrival.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @prearrival }
    end
  end

  # GET /famicles/:famicle_id/children/new
  def new
    @prearrival = Prearrival.new(:child => @child)
  end

  def edit
    @prearrival = Prearrival.find(params[:id])
  end

  def create
    @prearrival = Prearrival.new(params[:prearrival])

    if @prearrival.save
      flash[:notice] = "prearrival was successfully crreated."
      redirect_to famicle_child_prearrival_path(@child.famicle, @child, @prearrival)
    else
      render :action => :new
    end
  end

  def update
    @prearrival = Prearrival.find(params[:id])
    if @prearrival.update_attributes(params[:prearrival])
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
end
