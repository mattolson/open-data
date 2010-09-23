class PressItemsController < ApplicationController
  before_filter :find_press_item, :only => [:edit, :update, :destroy]
  before_filter :authenticate_admin!, :except => [:index]

  # GET /press_items
  # GET /press_items.xml
  def index
    @press_items = PressItem.find(:all, :order => 'published_at desc')

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @press_items }
    end
  end

  # GET /press_items/new
  # GET /press_items/new.xml
  def new
    @press_item = PressItem.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @press_item }
    end
  end

  # GET /press_items/1/edit
  def edit
  end

  # POST /press_items
  # POST /press_items.xml
  def create
    @press_item = PressItem.new(params[:press_item])
    @press_item.save!

    respond_to do |wants|
      flash[:notice] = 'News item was successfully created.'
      wants.html { redirect_to news_url }
      wants.xml  { render :xml => @press_item, :status => :created, :location => @press_item }
    end
  end

  # PUT /press_items/1
  # PUT /press_items/1.xml
  def update
    @press_item.update_attributes!(params[:press_item])

    respond_to do |wants|
      flash[:notice] = 'News item was successfully updated.'
      wants.html { redirect_to news_url }
      wants.xml  { head :ok }
    end
  end

  # DELETE /press_items/1
  # DELETE /press_items/1.xml
  def destroy
    @press_item.destroy

    respond_to do |wants|
      wants.html { redirect_to news_url }
      wants.xml  { head :ok }
    end
  end

  private
    def find_press_item
      @press_item = PressItem.find(params[:id])
    end

end
