require_relative "spec_helper"
require_relative "../sinatra_chat.rb"

def app
  SinatraChat
end

describe SinatraChat do
  it "responds with a welcome message" do
    get '/'

    last_response.body.must_include 'Welcome to the Sinatra Template!'
  end
end
