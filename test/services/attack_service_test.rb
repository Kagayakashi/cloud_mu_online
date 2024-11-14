require "test_helper"

class AttackServiceTest < ActiveSupport::TestCase
  def setup
    @character = characters(:one)
    @spider = monsters(:one)
  end
end
