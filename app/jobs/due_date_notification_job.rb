class DueDateNotificationJob
	include Sidekiq::Job

	def perform
		books_loan = BookLoan.where(status: 'checked_out', due_date: Date.tomorrow)
		books_loan.each { |e| UserMailer.due_date_notification_email(e).deliver_now }
	end
end