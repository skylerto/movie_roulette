$stdout.sync = true

require 'sinatra'
require 'google_assistant'
require 'json'

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end

  post '/' do
    content_type :json
    data = JSON.parse(request.body.read)
    assistant_response = GoogleAssistant.respond_to(data, response) do |assistant|
      assistant.intent.main do
        assistant.tell("<speak>I can respond, too!</speak>")
      end
    end
    assistant_response
  end
end
