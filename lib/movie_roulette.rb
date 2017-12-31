$stdout.sync = true

require 'sinatra'
require 'google_assistant'
require 'json'
require 'sinatra/json'
require_relative 'movie_roulette/genre'
require_relative 'movie_roulette/movie'
require_relative 'movie_roulette/config'
require_relative 'movie_roulette/executor'

module MovieRoulette
  class App < Sinatra::Base
    get '/' do
      'Hello world!'
    end

    post '/' do
      content_type :json
      data = JSON.parse(request.body.read)
      assistant_response = Executor.execute(data, response)
      json assistant_response
    end
  end
end
