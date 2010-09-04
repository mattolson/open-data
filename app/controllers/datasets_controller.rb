class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.find(:all, :conditions => ["published_at is not null"])
  end

  def show
    @dataset = Dataset.find_by_id(params[:id])
  end

  def new
    @dataset = Dataset.new
  end

  def edit
    @dataset = Dataset.find_by_id(params[:id])
  end

  def create
    @dataset = Dataset.new(params[:dataset])
    
    if @dataset.save
      flash[:notice] = 'Dataset was successfully created.'
      redirect_to(@dataset)
    else
      render :action => 'new'
    end
  end

  def update
    @dataset = Dataset.find_by_id(params[:id])

    if @dataset.update_attributes(params[:dataset])
      flash[:notice] = 'Dataset was successfully updated.'
      redirect_to(@dataset)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dataset = Dataset.find_by_id(params[:id])
    @dataset.destroy
    redirect_to datasets_path
  end
end
