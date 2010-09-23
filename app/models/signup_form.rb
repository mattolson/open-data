class SignupForm < MailForm
  sender Configs.notification_email_from
  recipients Configs.notification_email_to
  subject "Email Signup - Open Data Project"

  attribute :email, :validate => ARValidation::EMAIL_RE
  
  def deliver!
    if valid?
      deliver
    else
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
