class Mailer < ActionMailer::Base
  def new_company
    setup
    subject 'New company on Open Data Project'
  end

  def new_app
    setup
    subject 'New app on Open Data Project'
  end
  
  private
    def setup
      from Configs.notification_email
      recipients Configs.notification_email
    end
end
