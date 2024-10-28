class CharacterCreatorService
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def create
    character = @user.characters.build(character_params)

    if character.type.present?
      subclass_instance = character.type.constantize.new(@params.except(:type))
      subclass_instance.user = @user
      subclass_instance.set_default_values
      return subclass_instance.save ? subclass_instance : nil
    end
  end

  private

  def character_params
    @params.permit(:name, :type)
  end
end
