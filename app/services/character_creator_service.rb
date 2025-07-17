class CharacterCreatorService
  attr_reader :character

  def initialize(user:, name:, type:)
    @user = user
    @name = name
    @type = type
  end

  def call
    return invalid_character unless valid_character_type?

    @character = @type.constantize.new(user: @user, name: @name)

    if @character.save && @user.characters.empty?
      @user.update_attribute(:character, @character)
    end

    @character
  end

  private

  def valid_character_type?
    Characters::Player.subclasses.map(&:name).include?(@type)
  end

  def invalid_character
    @character = @user.characters.build(user: @user, name: @name)
    @character.errors.add(:type, "is not a valid character type")
    @character
  end
end
