class User < ApplicationRecord
  has_secure_password

  has_many :characters, dependent: :destroy
  has_one :active_character, dependent: :destroy
  has_one :current_character, through: :active_character, source: :character

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :username, length: { minimum: 4, maximum: 20 }
  validates :password, length: { minimum: 4, maximum: 20 }
  validates :email, length: { minimum: 8, maximum: 100 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  normalizes :email, with: ->(email) {email.strip.downcase}
  normalizes :username, with: ->(username) {username.strip.capitalize}

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  # Todo
  # generates_token_for :email_confirmation, expires_in: 24.hours do
  #   email
  # end
end
