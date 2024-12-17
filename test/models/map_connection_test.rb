require "test_helper"

class MapConnectionTest < ActiveSupport::TestCase
  def setup
    @lorencia = maps(:one)
    @noria = maps(:five)
    @devias = maps(:four)
  end

  test "should not be valid with empty all attributes" do
    connection = MapConnection.new
    assert_not connection.valid?
  end

  test "should not be valid connection if it already exist from map" do
    first_connection = @lorencia.map_connections.create(connected_map: @noria)
    assert first_connection.valid?

    second_connection = @lorencia.map_connections.build(connected_map: @noria)
    assert_not second_connection.valid?
  end

  test "should be valid with filled all attributes" do
    connection = MapConnection.new(map: @lorencia, connected_map: @noria)
    assert connection.valid?
    connection = MapConnection.new(map: @noria, connected_map: @lorencia)
    assert connection.valid?

    connection = MapConnection.new(map: @lorencia, connected_map: @devias)
    assert connection.valid?
    connection = MapConnection.new(map: @devias, connected_map: @lorencia)
    assert connection.valid?
  end

  test "should be valid build from map" do
    connection = @lorencia.map_connections.build(connected_map: @noria)
    assert connection.valid?
  end

  test "should be created Dungeon map with connection from Lorencia" do
    dungeon = @lorencia.connected_maps.create(name: "Dungeon")
    assert dungeon.valid?
  end
end
