class InsertLorenciaIntoMaps < ActiveRecord::Migration[7.1]
  def change
    Map.delete_all
    Map.create :name => "Lorencia", :min_level => 1, :teleport_cost => 0
  end
end
