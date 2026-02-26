class CharacterCreatorService
  def initialize(user:, name:, type:)
    @user = user
    @name = name
    @type = type
  end

  def call
    @character = Characters::Player.new(user: @user, type: @type, name: @name)

    is_first_character = @user.characters.count.zero?
    if @character.save && is_first_character
      @user.update_attribute(:character, @character)
    end

    @character
  end
end
