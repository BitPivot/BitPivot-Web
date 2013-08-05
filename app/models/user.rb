class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :role

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email.downcase! }

  validates :email,
            presence: true,
            format: {with: VALID_EMAIL_REGEX}
  has_secure_password
end
