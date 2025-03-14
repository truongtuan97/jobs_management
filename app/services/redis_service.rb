class RedisService
  def self.set_key(key, value, expire_in = nil)
    redis.set(key, value)
    redis.expire(key, expire_in) if expire_in
  end

  def self.get_key(key)
    redis.get(key)
  end

  def self.delete_key(key)
    redis.del(key)
  end

  def self.all_keys
    redis.keys('*')
  end

  def self.redis
    @redis ||= REDIS
  end
end
