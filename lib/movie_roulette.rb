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
            "<speak>Hello, what genre would you like?</speak>",
            [
              "<speak>If you said something, I didn't hear you.</speak>",
              "<speak>Did you say something?</speak>"
            ]
          )
        end

        assistant.intent.text do
          genre = Genre.find(name: assistant.arguments[0].text_value.downcase)
          if genre.nil?
            respond_with = 'I could not find the genre you were looking for'
            assistant.ask("<speak>#{respond_with}</speak>")
            return
          end

          movies = Movie.find(genre: genre)
          if movies.nil?
            respond_with = "I could not find anything in the genre #{genre.name}, try another genre?"
            assistant.ask("<speak>#{respond_with}</speak>")
            return
          end

          number = rand(movies.size)
          movie = movies[number]
          if movie.nil?
            respond_with = "I could not find anything in the genre #{genre.name}, try another genre?"
            assistant.ask("<speak>#{respond_with}</speak>")
            return
          end

          respond_with = "How about #{movie.title}?"
          assistant.tell(respond_with)
          return
        end
      end
      json assistant_response
    end
  end
end
