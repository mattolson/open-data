# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :current_user_session, :controller_name, :page_title, :set_page_title, :add_css_include, :extra_css_includes, :add_js_include, :extra_js_includes, :user_agent
  filter_parameter_logging :password, :password_confirmation
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Set page title
  def set_page_title(title)
    @page_title = title
  end
  
  def page_title
    @page_title
  end

  # Port escape_html to controller
  def h(s)
    CGI.escapeHTML(s)
  end
  
  # Allow individual views to add css files to the list
  def add_css_include(css)
    (@extra_css_includes ||= []) << css
  end

  def extra_css_includes
    @extra_css_includes || []
  end

  # Allow individual views to add js files to the list
  def add_js_include(js)
    (@extra_js_includes ||= []) << js
  end

  def extra_js_includes
    @extra_js_includes || []
  end

  def user_agent
    request.user_agent ? request.user_agent.downcase : ''
  end
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
    
    def require_admin
      return require_user && current_user.is_admin?
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
