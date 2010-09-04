# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :controller_name, :page_title, :set_page_title, :add_css_include, :extra_css_includes, :add_js_include, :extra_js_includes, :user_agent
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
end
