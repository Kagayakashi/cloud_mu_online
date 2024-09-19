class MapConnection < ApplicationRecord
  belongs_to :map
  belongs_to :connected_map, class_name: 'Map'

  validates :map_id, uniqueness: { scope: :connected_map_id }
end
