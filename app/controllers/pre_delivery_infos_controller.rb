class PreDeliveryInfosController < ApplicationController
  before_filter :login_required, :load_child

  # GET /pre_delivery_infos/1
  # GET /pre_delivery_infos/1.xml
  def show
    @pre_delivery_info = PreDeliveryInfo.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @pre_delivery_info }
    end
  end

  # GET /famicles/:famicle_id/children/new
  def new
    @pre_delivery_info = PreDeliveryInfo.new(:child => @child)
  end

  def edit
    @pre_delivery_info = PreDeliveryInfo.find(params[:id])
  end

  def create
    @pre_delivery_info = PreDeliveryInfo.new(params[:pre_delivery_info])

    if @pre_delivery_info.save
      flash[:notice] = "pre_delivery_info was successfully crreated."
      redirect_to famicle_child_pre_delivery_info_path(@child.famicle, @child, @pre_delivery_info)
    else
      render :action => :new
    end
  end

  def update
    @pre_delivery_info = PreDeliveryInfo.find(params[:id])
    if @pre_delivery_info.update_attributes(params[:pre_delivery_info])
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
