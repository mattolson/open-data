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
  
  # S3 access key id
  def self.s3_key
    return @@S3_KEY if defined?(@@S3_KEY)
    @@S3_KEY = ENV['S3_KEY']
  end

  # S3 access key secret
  def self.s3_secret
    return @@S3_SECRET if defined?(@@S3_SECRET)
    @@S3_SECRET = ENV['S3_SECRET']
  end

  # S3 bucket
  def self.s3_bucket
    return @@S3_BUCKET if defined?(@@S3_BUCKET)
    @@S3_BUCKET = ENV['S3_BUCKET']
  end

  # Disqus shortname
  def self.disqus_shortname
    return @@DISQUS_SHORTNAME if defined?(@@DISQUS_SHORTNAME)
    @@DISQUS_SHORTNAME = ENV['DISQUS_SHORTNAME']
  end
  
  # Name of company running this site (for press items related to dataset updates)
  def self.company_name
    return @@COMPANY_NAME if defined?(@@COMPANY_NAME)
    @@COMPANY_NAME = ENV['COMPANY_NAME']
  end

  # Email address to use for site notifications
  def self.notification_email
    return @@NOTIFICATION_EMAIL if defined?(@@NOTIFICATION_EMAIL)
    admin = Admin.find(:first)
    admin_email = admin ? admin.email : ''
    @@NOTIFICATION_EMAIL = "\"#{self.company_name} Open Data Project\" <#{admin_email}>"
  end
end
