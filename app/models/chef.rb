class Chef < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :chefname, presence: true, length: { minimum: 3, maximum: 40}
	VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email, presence: true, length: {maximum: 105},
							uniqueness: { case_sensitive: false },
							format: { with: VALID_EMAIL_REGEX }
end 