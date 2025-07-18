class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :characters, class_name: "Characters::Player", dependent: :destroy
  belongs_to :character, class_name: "Characters::Player", optional: true

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 4..20 }
  validates :email, presence: true, uniqueness: true, length: { in: 8..100 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, confirmation: true, length: { in: 4..20 }

  normalizes :email, with: ->(v) { v.strip.downcase }
  normalizes :username, with: ->(v) { v.strip.capitalize }

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
end
