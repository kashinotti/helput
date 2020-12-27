# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

def contact
  
  contact = Contact.new(name: 'テストユーザー', email: 'ryo.ka.notti@gmail.com', subject: 'お問い合わせテスト', message: 'お問い合わせのテストです')
  ContactMailer.contact_mail(contact)
end


end
