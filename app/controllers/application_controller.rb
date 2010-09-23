# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :controller_name, :page_title, :set_page_title, :add_css_include, :extra_css_includes, :add_js_include, :extra_js_includes, :user_agent, :standard_flashes
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :lookup_news, :init_signup

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
  
  protected
    def lookup_news
      @press_preview = PressItem.find(:all, :order => 'published_at desc', :limit => 3)
    end

    def init_signup
      @signup_form = SignupForm.new
    end
    
    # Override default rescue
    alias :orig_rescue_action_in_public :rescue_action_in_public
    def rescue_action_in_public(exception)
      # Log error using ExceptionLoggable unless a 404 or typical invalid record exception that gets handled below
      if response_code_for_rescue(exception) != :not_found && !exception.is_a?(ActiveRecord::RecordInvalid)
        #log_exception(exception)
      end
      
      # Call parent implementation
      orig_rescue_action_in_public(exception)
    end

    # By rescuing ActiveRecord validation errors, we handle the common pattern
    # of save/update followed by redirection. This allows us to use save! in our
    # controller methods.
    alias :orig_rescue_action_locally :rescue_action_locally
    def rescue_action_locally(exception)
      # Check for special cases
      if exception.is_a?(ActiveRecord::RecordInvalid)
        # Handle common ActiveRecord validation exception centrally
        render_invalid_record(exception.record)
      else
        # Call parent implementation
        orig_rescue_action_locally(exception)
      end
    end

    # Handle common ActiveRecord validation errors. You can control the redirection
    # behavior by setting @redirect_on_error to the path to redirect to. If not set,
    # the default is to redirect to new or edit as the case may be.
    def render_invalid_record(record)
      # Stuff error messages into flash
      class_name = record.class.to_s.underscore
      flash_error_messages_for(class_name.to_sym)
    
      # Default error response
      respond_to do |format|
        format.html { @redirect_on_error ? redirect_to(@redirect_on_error) : render(:action => @redirect_action_on_error || (record.new_record? ? :new : :edit)) }
        format.xml { render :xml => record.errors, :status => :unprocessable_entity }
        format.js { render :json => {:success => false, :msg => standard_flashes(class_name)} }
      end
    end

    # Instead of using form.error_messages, we prefer to format RecordInvalid errors
    # nicely in the flash block.
    def flash_error_messages_for(*params)
      options = params.extract_options!.symbolize_keys
      objects = params.collect {|object_name| instance_variable_get("@#{object_name}") }.compact
      count   = objects.inject(0) {|sum, object| sum + object.errors.count }
      return '' if count.zero?

      messages = ''
      objects.each do |object|
        object.errors.each do |attr, msg|
          attr = attr.to_s
          if attr == 'base'
            messages += "<li>#{msg}</li>"
          else
            messages += "<li>#{(object.respond_to?(:attribute_display_name_overrides) && object.attribute_display_name_overrides(attr)) || attr.humanize} #{msg}</li>" 
          end
        end
      end

      messages = "<h3>Sorry, there was a problem with the information you submitted.</h3><ul>#{messages}</ul>"
      if @redirect_on_error
        flash[:error] = messages
      else
        flash.now[:error] = messages
      end
    end

    def standard_flashes(flash_prefix = '')
      flashes = ""
      notice_flash = flash_prefix + (flash_prefix.empty? ? '' : '_') + 'notice'
      error_flash = flash_prefix + (flash_prefix.empty? ? '' : '_') + 'error'
      flash_container = flash_prefix + (flash_prefix.empty? ? '' : '_') + 'flashes'

      if flash[:notice]
        flash_id = "flash_#{notice_flash}"
        flashes += "<div id='#{flash_id}' class='notice'>"
        flashes += "<a href='' onclick=\"$('##{flash_id}').fadeOut('fast')\" class='clear close_box'>X</a>"
        flashes += flash[:notice]
        flashes += "</div>"
      end

      if flash[:alert] or flash[:error]
        flash_id = "flash_#{error_flash}"
        flashes += "<div id='#{flash_id}' class='error'>"
        flashes += "<a href='' onclick=\"$('##{flash_id}').fadeOut('fast')\" class='clear close_box'>X</a>"
        flashes += flash[:alert] if flash[:alert]
        flashes += flash[:error] if flash[:error]
        flashes += "</div>"
      end

      flashes += '<script type="text/javascript">$("#' + flash_container + '").fadeIn("fast", function() { if (IE7) {IE7.recalc();} });</script>' unless flashes.blank?
    	flashes
    end
end
