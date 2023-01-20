RubyOuath.configure do |c|
  c.client_id = ENV['CLIENT_ID']
  c.client_secret = ENV['CLIENT_SECRET']
  c.provider = 'BitBucket'
end