class Rack::Attack
  # Dùng Redis làm cache store
  Rack::Attack.cache.store = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'))

  # 1. Chặn tất cả các request từ một IP cụ thể
  blocklist('block 192.168.1.100') do |req|
    req.ip == '192.168.1.100'
  end

  # 2. Giới hạn số request cho mỗi IP (5 requests trong 10 giây)
  throttle('limit requests per IP', limit: 5, period: 10.seconds) do |req|
    req.ip
  end

  # 3. Chặn các request có User-Agent bất thường (ví dụ: spam bot)
  blocklist('block bad user agent') do |req|
    req.user_agent =~ /BadBot/i
  end

  # 4. Giới hạn số lần đăng nhập thất bại
  throttle('limit login attempts', limit: 5, period: 60.seconds) do |req|
    if req.path == '/login' && req.post?
      req.ip
    end
  end

  # 5. Tạo danh sách whitelist (IP được phép bypass tất cả luật)
  safelist('allow localhost') do |req|
    req.ip == '127.0.0.1'
  end
end