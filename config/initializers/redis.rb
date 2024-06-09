require 'redis'
$redis = Redis.new(port: ENV["REDIS_PORT"])
