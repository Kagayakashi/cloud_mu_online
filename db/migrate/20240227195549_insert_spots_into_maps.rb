class InsertSpotsIntoMaps < ActiveRecord::Migration[7.1]
  def change
    Spot.delete_all
    Spot.create :name => "Beginner Adventurer's Camp", :map => Map.first # Lorencia
  end
end
