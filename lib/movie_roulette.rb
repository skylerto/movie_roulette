$stdout.sync = true

require 'sinatra'
require 'google_assistant'
require 'json'
require 'sinatra/json'
require_relative 'movie_roulette/genre'
require_relative 'movie_roulette/movie'
require_relative 'movie_roulette/config'

module MovieRoulette
  class App < Sinatra::Base
    get '/' do
      'Hello world!'
    end

    post '/' do
      content_type :json
      data = JSON.parse(request.body.read)
      assistant_response = GoogleAssistant.respond_to(data, response) do |assistant|
        assistant.intent.main do
          assistant.ask(
            "<speak>Hi there! Say something, please.</speak>",
            [
              "<speak>If you said something, I didn't hear you.</speak>",
              "<speak>Did you say something?</speak>"
            ]
          )
        end

        assistant.intent.text do
          case assistant.arguments[0].text_value.downcase
          when "hello"
            respond_with = "Hi there!"
          when "goodbye"
            respond_with = "See you later!"
          else
            respond_with = "I heard you say #{assistant.arguments[0].text_value}, but I don't know what that means."
          end

          assistant.tell(respond_with)
        end
      end
      json assistant_response
    end
  end
end
