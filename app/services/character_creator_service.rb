class CharacterCreatorService
  def initialize(user:, name:, type:)
    @user = user
    @name = name
    @type = type
  end

  def call
    @character = Characters::Player.new(user: @user, type: @type, name: @name)

    if @user.characters.empty? && @character.save
      @user.update(character: @character)
    end

    @character
  end
end
