class CharacterCreatorService
  def initialize(user:, name:, type:)
    @user = user
    @name = name
    @type = type
    @character = Characters::Character.new(user: @user, name: @name, type: @type)
  end

  def call
    if @character.invalid?
      return @character
    end
    @character = @character.type.constantize.new(user: @user, name: @name)
    @character.save
    @character
  end

  private

  def valid_character_type?
    if Characters::Character.subclasses.map(&:name).include?(@type)
      true
    else
      @character.errors.add(:type, "is not a valid character type")
      false
    end
  end
end
