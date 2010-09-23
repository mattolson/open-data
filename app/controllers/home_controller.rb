class HomeController < ApplicationController
  def index
    @datasets = Dataset.find(:all, :conditions => ["is_featured = ?", true], :limit => 3, :order => 'last_uploaded_at desc')
    @apps = App.find(:all, :conditions => ["is_published = ? and is_featured = ?", true, true], :limit => 3, :order => 'created_at desc')
  end

  def contact
    @contact_form = ContactForm.new

    if request.post?
      @redirect_action_on_error = :contact
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.deliver!
      flash[:notice] = "Your message has been sent. Thanks!"
      redirect_to contact_path
    end
  end

  def email_signup
    @signup_form = SignupForm.new(params[:signup_form])
    @signup_form.deliver!
    
    respond_to do |wants|
      wants.js { render :json => {:success => true, :msg => "<h2>We've added you to the list. Thanks for your interest!</h2>"} }
    end
  end

  def about
  end

  def license
  end
end
