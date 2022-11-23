class ConfirmationMailer < Devise::Mailer
  default from: 'ahmad.naeemllah@devsinc.com'

  def self.mailer_name
    'devise/mailer'
  end
end
