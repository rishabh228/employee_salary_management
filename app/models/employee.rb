class Employee < ApplicationRecord
	validates :first_name, :last_name, :email, :phone_numbers, :doj, :salary, presence: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :phone_numbers, format: { with: /\A(\d{10},)*\d{10}\z/, message: "should be comma-separated 10 digit numbers" }
	validates :salary, numericality: { greater_than: 0 }
end
