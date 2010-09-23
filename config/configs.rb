# A convenient wrapper for fixed configuration information.
# Data structures are available via class methods. Data is
# cached after first calculation. Because of this you need
# to make sure not to modify the returned value, or that will
# affect all future requests!
class Configs

  def self.select_lists
    return @@SELECT_LISTS if defined?(@@SELECT_LISTS)
    
    # dataset_categories
    # The value also acts as a url slug
    dataset_categories = SelectList.new
    dataset_categories.add('direct', 'Direct')
    dataset_categories.add('indirect', 'Indirect')
    dataset_categories.add('philanthropy', 'Philanthropy')

    # Return the list of lists
    @@SELECT_LISTS = {
      "dataset_categories" => dataset_categories
    }
  end

  # Default dataset tags
  # format: [{:value => 'asdf'},...]
  # must be non-empty due to autosuggest plugin bug
  def self.dataset_tags
    return @@DATASET_TAGS if defined?(@@DATASET_TAGS)
    @@DATASET_TAGS = [{}]
  end

  # Default dataset standards tags
  # format: [{:value => 'asdf'},...]
  # must be non-empty due to autosuggest plugin bug
  def self.dataset_standards
    return @@DATASET_STANDARDS if defined?(@@DATASET_STANDARDS)
    @@DATASET_STANDARDS = [{:value => 'GRI'}]
  end

  # Default dataset certifications tags
  # format: [{:value => 'asdf'},...]
  # must be non-empty due to autosuggest plugin bug
  def self.dataset_certifications
    return @@DATASET_CERTIFICATIONS if defined?(@@DATASET_CERTIFICATIONS)
    @@DATASET_CERTIFICATIONS = [{}]
  end
  
  # Name of company running this site (for press items and such)
  def self.company_name
    return @@COMPANY_NAME if defined?(@@COMPANY_NAME)
    @@COMPANY_NAME = 'Seventh Generation'
  end

  # Email address to use for site notifications
  def self.notification_email_from
    return @@NOTIFICATION_EMAIL_FROM if defined?(@@NOTIFICATION_EMAIL_FROM)
    @@NOTIFICATION_EMAIL_FROM = '"Open Data App" <app@rubycloud.com>'
  end

  # Email address to use for site notifications
  def self.notification_email_to
    return @@NOTIFICATION_EMAIL_TO if defined?(@@NOTIFICATION_EMAIL_TO)
    @@NOTIFICATION_EMAIL_TO = '"Matt Olson" <molson@rubycloud.com>'
  end
end
