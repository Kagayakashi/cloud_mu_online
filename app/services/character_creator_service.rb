class CharacterCreatorService
  def initialize(user, character_params)
    @user = user
    @character_params = character_params
  end

  def call
    return false unless get_profession
    return false unless create_character
    @character.set_default_values
    @character
  end

  private

  def get_profession
    profession = Profession.find_by(code: @character_params[:profession])
    return false unless profession
    @character_params[:profession] = profession
  end

  def create_character
    @character = @user.characters.build(@character_params)
  end
end
