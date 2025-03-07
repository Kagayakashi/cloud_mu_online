class User < ApplicationRecord
  has_secure_password

  has_many :characters, class_name: "Characters::Character", dependent: :destroy
  has_one :player, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :username, length: { minimum: 4, maximum: 20 }
  validates :password, length: { minimum: 4, maximum: 20 }
  validates :email, length: { minimum: 8, maximum: 100 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :username, with: ->(username) { username.strip.capitalize }

  # Old guest accounts will be deleted every day
  scope :old_guests, -> {
    where(is_guest: true)
    .where("last_login_at <= ?", 1.day.ago)
  }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  def update_last_login_time
    update_column(:last_login_at, Time.current)
  end

  # Todo
  # generates_token_for :email_confirmation, expires_in: 24.hours do
  #   email
  # end
end
