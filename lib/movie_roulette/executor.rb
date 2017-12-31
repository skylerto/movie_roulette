require_relative 'commands/main'

module Executor
  class << self
    def execute(data, response)
      assistant_response = GoogleAssistant.respond_to(data, response) do |assistant|
        assistant.intent.main do
          MainCommand.new(assistant).execute
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
          else
            assistant.tell('Lets try again later')
          end
        end
      end
    end
  end
end
