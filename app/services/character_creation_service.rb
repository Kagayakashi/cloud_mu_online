class CharacterCreationService
  DARK_WIZARD = 1.freeze
  DARK_KNIGHT = 2.freeze
  LIGHT_ELF = 3.freeze

  def initialize(name:, type:)
    @character_name = name
    @character_type = type
  end

  def call
    character_class = character_class_from_type

    return unless character_class

    character_class.new(name: @character_name)
  end

  private

  def character_class_from_type
    case @character_type.to_i
    when DARK_WIZARD then CharacterTypes::DarkWizard
    when DARK_KNIGHT then CharacterTypes::DarkKnight
    when LIGHT_ELF then CharacterTypes::LightElf
    else
      nil
    end
  end
end
