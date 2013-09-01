class Inquiry < ActiveRecord::Base
  attr_accessible :author, :email, :phone, :content

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, format: { with: VALID_EMAIL_REGEX }, unless: :phone_present?
  validates :content, presence: true

  validates_presence_of :email, unless: :phone_present?
  validates_presence_of :phone, unless: :email_present?

  def phone_present?
    phone.length != 0
  end

  def email_present?
    email.length != 0
  end
end
