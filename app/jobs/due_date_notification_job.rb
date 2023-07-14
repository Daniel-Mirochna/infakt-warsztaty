class DueDateNotificationJob
	include Sidekiq::Job

	def perform
		books_loans
	end

	private

	def books_loans
		loans = BookLoan.where(status: 'checked_out', due_date: Date.tomorrow)
		loans.each { |book_loan| UserMailer.due_date_notification_email(book_loan).deliver_now }
	end
end