class DatasetsController < ApplicationController
  before_filter :find_dataset, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!, :except => [:index, :show]

  # GET /datasets
  # GET /datasets.xml
  def index
    @datasets = Dataset.all

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
    prep_dataset_form
    
    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @dataset }
    end
  end

  # GET /datasets/1/edit
  def edit
    prep_dataset_form
  end

  # POST /datasets
  # POST /datasets.xml
  def create
    @dataset = Dataset.new(params[:dataset])
    prep_dataset_form
    @dataset.save!

    respond_to do |wants|
      flash[:notice] = 'Dataset was successfully created.'
      wants.html { redirect_to(@dataset) }
      wants.xml  { render :xml => @dataset, :status => :created, :location => @dataset }
    end
  end

  # PUT /datasets/1
  # PUT /datasets/1.xml
  def update
    prep_dataset_form
    @dataset.update_attributes!(params[:dataset])
    
    respond_to do |wants|
      flash[:notice] = 'Dataset was successfully updated.'
      wants.html { redirect_to(@dataset) }
      wants.xml  { head :ok }
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

  protected
    def find_dataset
      @dataset = Dataset.find(params[:id])
    end
    
    def prep_dataset_form
      @max_files = Dataset::MAX_ATTACHMENTS

      tags = Dataset.tag_counts_on(:tags)
      @tags = tags.empty? ? Configs.dataset_tags : tags.map { |tag| {:value => tag.name} }
      @current_tags = @dataset.tag_list.map { |tag| {:value => tag} }

      standards = Dataset.tag_counts_on(:standards)
      @standards = standards.empty? ? Configs.dataset_standards : standards.map { |tag| {:value => tag.name} }
      @current_standards = @dataset.standard_list.map { |tag| {:value => tag} }

      certifications = Dataset.tag_counts_on(:certifications)
      @certifications = certifications.empty? ? Configs.dataset_certifications : certifications.map { |tag| {:value => tag.name} }
      @current_certifications = @dataset.certification_list.map { |tag| {:value => tag} }
    end
end
