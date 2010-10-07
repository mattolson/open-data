class ContactForm < MailForm
  sender Configs.notification_email
  recipients Configs.notification_email
  subject "Contact - Open Data Project"

  attribute :name,    :validate => true
  attribute :email,   :validate => ARValidation::EMAIL_RE
  attribute :message, :validate => true
  
  def deliver!
    if valid?
      deliver
    else
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
