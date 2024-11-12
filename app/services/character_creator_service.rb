class CharacterCreatorService
  def initialize(user:, name:, type:)
    @user = user
    @name = name
    @type = type
  end

  def call
    return invalid_character unless valid_character_type?

    character = @type.constantize.new(user: @user, name: @name)
    character.save
    character
  end

  private

  def valid_character_type?
    Characters::Character.subclasses.map(&:name).include?(@type)
  end

  def invalid_character
    character = Characters::Character.new(user: @user, name: @name)
    character.errors.add(:type, "is not a valid character type")
    character
  end
end
