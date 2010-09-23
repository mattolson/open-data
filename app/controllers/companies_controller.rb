class CompaniesController < ApplicationController
  before_filter :find_company, :only => [:edit, :update, :destroy]
  before_filter :authenticate_admin!, :except => [:index, :new, :create]

  # GET /companies
  # GET /companies.xml
  def index
    @companies = Company.find(:all, :conditions => ["is_published = ?", true], :order => 'is_partner desc, name')
    @pending_companies = Company.find(:all, :conditions => ["is_published = ?", false], :order => 'created_at desc')

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @companies }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company])
    @company.save!
    Mailer.deliver_new_company

    respond_to do |wants|
      flash[:notice] = "Your request has been submitted. We'll get back to you soon. Thanks!"
      wants.html { redirect_to(companies_url) }
      wants.xml  { render :xml => @company, :status => :created, :location => @company }
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company.update_attributes!(params[:company])
    
    respond_to do |wants|
      flash[:notice] = 'Participant was successfully updated.'
      wants.html { redirect_to(companies_url) }
      wants.xml  { head :ok }
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company.destroy

    respond_to do |wants|
      wants.html { redirect_to(companies_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_company
      @company = Company.find(params[:id])
    end

end
