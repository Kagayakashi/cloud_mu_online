class InsertSpotsIntoMaps < ActiveRecord::Migration[7.1]
  def change
    Spot.delete_all
    lorencia = Map.first

    Spot.create :name => "Lorencia City", :map => lorencia
    Spot.create :name => "Beginner Adventurer's Camp", :map => lorencia
  end
end
