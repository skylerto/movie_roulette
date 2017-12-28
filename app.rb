$stdout.sync = true

require 'sinatra'
require 'google_assistant'
require 'json'
require 'sinatra/json'
require 'byebug'

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end

  post '/' do
    content_type :json
    data = JSON.parse(request.body.read)
    assistant_response = GoogleAssistant.respond_to(data, response) do |assistant|
      byebug
      assistant.intent.main do
        assistant.ask(
          prompt: "<speak>Hi there! Say something, please.</speak>",
          no_input_prompt: [
            "<speak>If you said something, I didn't hear you.</speak>",
            "<speak>Did you say something?</speak>"
          ]
        )
      end

      assistant.intent.text do
        assistant.tell("<speak>I can respond, too!</speak>")
      end
    end
    byebug
    json assistant_response
  end
end
