class SpawnMonsterJob
  include Sidekiq::Job

  def perform(monster_id, spot_id)
    SpotMonster.create!(monster: Monster.find(monster_id), spot: Spot.find(spot_id))
  end
end
