require 'bcrypt'

module PasswordHelper
  def self.digest(password)
    BCrypt::Password.create(password)
  end
end
