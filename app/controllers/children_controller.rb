class ChildrenController < ApplicationController
  before_filter :login_required, :load_famicle

  # GET /children
  # GET /children.xml
  def index
    @children = Child.find(:all)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @children }
    end
  end

  # GET /childs/1
  # GET /childs/1.xml
  def show
    @child = Child.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @child }
    end
  end

  # GET /famicles/:famicle_id/children/new
  def new
    @child = Child.new(:famicle => @famicle)
  end

  def edit
    @child = Child.find(params[:id])
  end

  def create
    @child = Child.new(params[:child])

    if @child.save
      flash[:notice] = "#{@child.name} was successfully crreated."
      redirect_to famicle_child_path(@famicle, @child)
    else
      @child.photo = nil
      render :action => :new
    end
  end

  def update
    @child = Child.find(params[:id])
    if @child.update_attributes(params[:child])
      flash[:notice] = "Successfully updated #{@child.name}"
      redirect_to famicle_child_path(@famicle, @child)
    else
      render :action => :edit
    end
  end

private
  def load_famicle
    @famicle = Famicle.find(params[:famicle_id])
  end

  def set_current_tab
    @current_tab = 'children'
  end
end
