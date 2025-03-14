# Sử dụng image Ruby có sẵn
FROM ruby:3.3.0

# Cài đặt các dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client 

RUN apt-get update && apt-get install -y librdkafka-dev

# Đặt thư mục làm việc là /app
WORKDIR /app

# Sao chép Gemfile và cài đặt gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Sao chép toàn bộ code vào container
COPY . .

# Cấu hình cổng mặc định
EXPOSE 3000

# Khởi động server
CMD ["rails", "server", "-b", "0.0.0.0"]
