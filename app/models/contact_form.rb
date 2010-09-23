class ContactForm < MailForm
  sender Configs.notification_email_from
  recipients Configs.notification_email_to
  subject "Contact - Open Data Project"

  attribute :name,      :validate => true
  attribute :email,     :validate => ARValidation::EMAIL_RE
  attribute :message,   :validate => true
  
  def send!
    if valid?
      deliver
    else
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
