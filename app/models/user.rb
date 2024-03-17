class User < ApplicationRecord
  has_secure_password

  has_many :characters, dependent: :destroy
  belongs_to :active_character,
    class_name: 'Character',
    foreign_key: 'active_character_id',
    dependent: :destroy,
    optional: true

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  normalizes :email, with: ->(email) {email.strip.downcase}
  normalizes :username, with: ->(username) {username.strip.capitalize}

  validates :username, length: { minimum: 4, maximum: 20 }
  validates :password, length: { minimum: 4, maximum: 20 }
  validates :email, length: { maximum: 50 }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  # Todo
  # generates_token_for :email_confirmation, expires_in: 24.hours do
  #   email
  # end
end
