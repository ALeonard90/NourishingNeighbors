require 'bcrypt'

class User < ActiveRecord::Base
	# attributes
 	attr_accessor :password

  # callbacks
  before_save :encrypt_password

	# associations
	has_many :meals
  has_many :cans
  has_many :greetings
  has_many :miscs

	# methods
	def authenticate(password)
		if BCrypt::Password.new(self.password_digest) == password
  		return self
    else
    	return nil
   	end
	end

  def encrypt_password
    if password.present?
      return self.password_digest = BCrypt::Password.create(password)
    end
  end
end