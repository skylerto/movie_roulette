$stdout.sync = true

require 'sinatra'
require 'google_assistant'

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end

  post '/' do
    puts request.body.read
    puts response
    assistant_response = GoogleAssistant.respond_to(request.body.read, response) do |assistant|
      assistant.intent.main do
        assistant.tell("<speak>I can respond, too!</speak>")
      end
    end

    render json: assistant_response
  end
end
