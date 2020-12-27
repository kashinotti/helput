class ContactMailer < ApplicationMailer
  
  def contact_mail(contact)
    @contact = contact
    mail(
      to: 'ryo.ka.notti@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
  
end
