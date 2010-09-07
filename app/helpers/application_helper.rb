# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def standard_flashes(flash_prefix = '')
    flashes = ""
    notice_flash = flash_prefix + (flash_prefix.empty? ? '' : '_') + 'notice'
    error_flash = flash_prefix + (flash_prefix.empty? ? '' : '_') + 'error'
    flash_container = flash_prefix + (flash_prefix.empty? ? '' : '_') + 'flashes'
    
    if flash[:notice]
      flash_id = "flash_#{notice_flash}"
      flashes += "<div id='#{flash_id}' class='notice'>"
      flashes += link_to_function image_tag('icons/fam_silk/cross.png', :alt => 'X', :style => 'width:16px;height:16px;'), "Effect.Fade('#{flash_id}', {duration:0.3})", :class => 'clear close_box'
      flashes += image_tag('icons/fam_silk/information.png', :alt => 'Info', :style => 'width:16px;height:16px;')
      flashes += flash[:notice]
      flashes += "</div>"
    end
    
    if flash[:alert] or flash[:error]
      flash_id = "flash_#{error_flash}"
      flashes += "<div id='#{flash_id}' class='error'>"
      flashes += link_to_function image_tag('icons/fam_silk/cross.png', :alt => 'X', :style => 'width:16px;height:16px;'), "Effect.Fade('#{flash_id}', {duration:0.3})", :class => 'clear close_box'
      flashes += image_tag('icons/fam_silk/error.png', :alt => 'Error', :style => 'width:16px;height:16px;')
      flashes += flash[:alert] if flash[:alert]
      flashes += flash[:error] if flash[:error]
      flashes += "</div>"
    end
    
    flashes += '<script type="text/javascript">new Effect.Appear("' + flash_container + '", { duration:0.3, afterFinish: function() { if (IE7) {IE7.recalc();} } });</script>' unless flashes.blank?
  	flashes
  end
  
  # Are we running in our arch-enemy Internet Explorer?
  def ie?
    user_agent.include?("msie")
  end

  # Are we running in the infamous Internet Explorer 6.0?
  def ie6?
    user_agent.include?("msie 6")
  end

  # Are we running in the somewhat more acceptable Internet Explorer 7.0?
  def ie7?
    user_agent.include?("msie 7")
  end

  # Are we running in our good friend WebKit?
  def safari?
    # Include camino as well since they share the same types of overrides (related to Apple form controls)
    user_agent.include?("applewebkit") || user_agent.include?("camino")
  end

  # Return full set of stylesheet includes. If browser is specified, output override stylesheets if they exist.
  def stylesheets
    # First the core files
    style_block = stylesheet_group(['core', 'formtastic', 'formtastic_changes'])
    
    # Controller specific css
    style_block += stylesheet_group([controller_name]) if File.exist?(File.join(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR, "#{controller_name}.css"))
    
    # Any one-off extras that have been defined in views (should be rare)
    unless extra_css_includes.empty?
      style_block += stylesheet_group(extra_css_includes)
    end
    
    # Return it
    style_block
  end

  # Check for style sheet overrides for the given list of names
  def stylesheet_group(files)
    # Check for overrides
    browser = nil
    overrides = []
    if ie6?
      # IE6 does it differently -- it needs both ie7 and ie6 stylesheets
      browser = 'ie6'
      files.each do |f|
        overrides << "#{f}_ie7" if File.exist?(File.join(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR, "#{f}_ie7.css"))
        overrides << "#{f}_ie6" if File.exist?(File.join(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR, "#{f}_ie6.css"))
      end
    else
      # Other browsers need just the single override stylesheet
      ['ie7', 'safari'].each do |b|
        if self.send("#{b}?")
          browser = b
          files.each { |f| overrides << "#{f}_#{b}" if File.exist?(File.join(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR, "#{f}_#{b}.css")) }
        end
    	end
    end
  	
  	# If overrides exist, merge them with ordinary files and create cached copy tagged by browser
  	style_tag_args = []
  	if browser.nil? || overrides.empty?
      style_tag_args += files
    else
      style_tag_args += files
      style_tag_args += overrides
    end
    
    # Return style tag(s)
    stylesheet_link_tag(*style_tag_args)
  end
  
  # Return full set of javascript includes
  def javascripts
    # First the core files
    scripts = ['jquery-1.4.2.min', 'application']

    # Controller specific js
    scripts << controller_name if File.exist?(File.join(ActionView::Helpers::AssetTagHelper::JAVASCRIPTS_DIR, "#{controller_name}.js"))

    # Any one-off extras that have been defined in views (should be rare)
    scripts += extra_js_includes
    
    # Dean Edwards' IE7 library if running IE6
    scripts << 'ie7' if ie6?
    
    # Return script block
    javascript_include_tag(*scripts) + "\n"
  end
end
