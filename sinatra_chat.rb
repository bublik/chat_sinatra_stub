class SinatraChat < Sinatra::Base
  configure do
    set :public_folder => "public", :static => true
    enable :logging
    file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  get "/" do
    erb :welcome
  end

  get '/discovery:format?' do
    json [
           { 'users' => '/users.json' },
           { 'rooms' => '/rooms.json' }
         ]
  end

  get '/users:format?' do
    sleep(1) &&
    json([{ name: 'User1 Last', id: 1 },
          { name: 'User2 Last', id: 2 },
          { name: 'User3 Last', id: 3 }])
  end

  get '/rooms:format?' do
    json [{ name: 'Room 1', id: 1, created_at: Time.now - 100.days },
          { name: 'Room 99', id: 99, created_at: Time.now },
          { name: 'Room 12', id: 12, created_at: Time.now - 12.days }]
  end

end

class Integer
  def days
    self * 60 * 60 * 24
  end
end