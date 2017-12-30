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
          assistant.conversation.state = "asking genre"
          assistant.ask(
            "<speak>Hello, what genre would you like?</speak>",
            [
              "<speak>If you said something, I didn't hear you.</speak>",
              "<speak>Did you say something?</speak>"
            ]
          )
        end

        assistant.intent.text do
          if assistant.conversation.state == "asking genre"
            genre = Genre.find(name: assistant.arguments[0].text_value.downcase)
            assistant.conversation.data["genre"] = genre
            if genre.nil?
              respond_with = 'I could not find the genre you were looking for'
              assistant.ask(respond_with, [respond_with])
            end

            movies = Movie.find(genre: genre)
            if movies.nil?
              respond_with = "I could not find anything in the genre #{genre.name}, try another genre?"
              assistant.ask(respond_with, [respond_with])
            end

            number = rand(movies.size)
            movie = movies[number]
            if movie.nil?
              respond_with = "I could not find anything in the genre #{genre.name}, try another genre?"
              assistant.ask(respond_with, [respond_with])
            end

            respond_with = "How about #{movie.title}?"

            assistant.conversation.state = "movie chosen"
            assistant.conversation.data["movie"] = movie.title

            assistant.ask(respond_with, [respond_with])
          elsif assistant.conversation.state == "movie chosen"
            puts assistant.conversation.state
            case assistant.arguments[0].text_value.downcase
            when 'tell me more'
              movie_title = assistant.conversation.data['movie']
              puts movie_title
              movie = Movie.find(title: movie_title)
              puts movie.inspect
              assistant.conversation.state = "movie chosen"
              assistant.conversation.data["movie"] = movie.title
              respond_with = "#{movie.overview}, how does that sound?"
              assistant.ask(respond_with, [respond_with])
            when 'something else'
              assistant.conversation.state = "asking genre"
              assistant.conversation.data['movie'] = nil
              respond_with = 'What genre would you like?'
              assistant.ask(respond_with, [respond_with])
            else
              assistant.tell('Lets try again later')
            end
          end
        end
      end
      json assistant_response
    end
  end
end
