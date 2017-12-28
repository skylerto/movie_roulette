require 'sinatra'
require 'google_assistant'

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end

  post '/' do
    puts params
    puts response
    assistant_response = GoogleAssistant.respond_to(params, response) do |assistant|
      assistant.intent.main do
        assistant.tell("<speak>I can respond, too!</speak>")
      end
    end

    render json: assistant_response
  end
end
