class DatasetsController < ApplicationController
  before_filter :find_dataset, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!, :except => [:index, :show]

  # GET /datasets
  # GET /datasets.xml
  def index
    @datasets = Dataset.find(:all, :conditions => ["published_at is not null"])

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @datasets }
    end
  end

  # GET /datasets/1
  # GET /datasets/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @dataset }
    end
  end

  # GET /datasets/new
  # GET /datasets/new.xml
  def new
    @dataset = Dataset.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @dataset }
    end
  end

  # GET /datasets/1/edit
  def edit
  end

  # POST /datasets
  # POST /datasets.xml
  def create
    @dataset = Dataset.new(params[:dataset])

    respond_to do |wants|
      if @dataset.save
        flash[:notice] = 'Dataset was successfully created.'
        wants.html { redirect_to(@dataset) }
        wants.xml  { render :xml => @dataset, :status => :created, :location => @dataset }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @dataset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /datasets/1
  # PUT /datasets/1.xml
  def update
    respond_to do |wants|
      if @dataset.update_attributes(params[:dataset])
        flash[:notice] = 'Dataset was successfully updated.'
        wants.html { redirect_to(@dataset) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @dataset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /datasets/1
  # DELETE /datasets/1.xml
  def destroy
    @dataset.destroy

    respond_to do |wants|
      wants.html { redirect_to(datasets_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_dataset
      @dataset = Dataset.find(params[:id])
    end

end
