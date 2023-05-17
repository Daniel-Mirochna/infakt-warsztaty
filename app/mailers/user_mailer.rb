class UserMailer < ApplicationMailer

  def loan_created_email(book_loan)
    @date = book_loan.due_date
    @title = book_loan.book.title
    email_address = book_loan.user.email
    email_subject = "Book loan mail"
    mail(to: email_address, subject: email_subject)
  end

  def due_date_notification_email(book_loan)
    @date = book_loan.due_date
    @title = book_loan.book.title
    email_address = book_loan.user.email
    email_subject = "Book loan mail"
    mail(to: email_address, subject: email_subject)
  end
end