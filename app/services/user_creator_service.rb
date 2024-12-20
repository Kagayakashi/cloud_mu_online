class UserCreatorService
  attr_reader :user

  def initialize
    @password = SecureRandom.alphanumeric(20)
    @username = generate_unique_username
    @email = "#{@username}@example.com"
  end

  def call
    @user = User.create!(
      username: @username,
      email: @email,
      password: @password,
      password_confirmation: @password,
      is_guest: true
    )
  end

  private

  def generate_unique_username
    "u_#{Time.now.strftime('%y%m%d%H%M%S')}#{SecureRandom.hex(2)}"
  end
end
