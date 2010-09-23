class AppsController < ApplicationController
  before_filter :find_app, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!, :except => [:index, :new, :create]

  # GET /apps
  # GET /apps.xml
  def index
    @apps = App.find(:all, :conditions => ["is_published = ?", true])
    @pending_apps = App.find(:all, :conditions => ["is_published = ?", false])

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @apps }
    end
  end

  # GET /apps/new
  # GET /apps/new.xml
  def new
    @app = App.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @app }
    end
  end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.xml
  def create
    @app = App.new(params[:app])
    @app.save!

    respond_to do |wants|
      flash[:notice] = "Your application has been submitted. You will receive an email once we've taken a look. Thanks!"
      wants.html { redirect_to(apps_url) }
      wants.xml  { render :xml => @app, :status => :created, :location => @app }
    end
  end

  # PUT /apps/1
  # PUT /apps/1.xml
  def update
    was_published = @app.is_published
    @app.update_attributes!(params[:app])
    publish_press_item if !was_published && @app.is_published
    
    respond_to do |wants|
      flash[:notice] = 'App was successfully updated.'
      wants.html { redirect_to(apps_url) }
      wants.xml  { head :ok }
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.xml
  def destroy
    @app.destroy

    respond_to do |wants|
      wants.html { redirect_to(apps_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_app
      @app = App.find(params[:id])
    end

    # Publish news item on creation
    def publish_press_item
      press_item = PressItem.new
      press_item.title = "New application added: #{@app.title}"
      press_item.source = Configs.company_name
      press_item.link = app_url(@app)
      press_item.published_at = DateTime.now
      press_item.save!
    end
end
