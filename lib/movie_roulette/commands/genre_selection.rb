class GenreSelection
  def initialize(assistant)
    @assistant = assistant
  end

  def execute
    genre = Genre.find(name: @assistant.arguments[0].text_value.downcase)
    @assistant.conversation.data['genre'] = genre
    if genre.nil?
      respond_with = 'I could not find the genre you were looking for'
      @assistant.ask(respond_with, [respond_with])
    end

    movies = Movie.find(genre: genre)
    if movies.nil?
      respond_with = "I could not find anything in the genre #{genre.name}, try another genre?"
      @assistant.ask(respond_with, [respond_with])
    end

    number = rand(movies.size)
    movie = movies[number]
    if movie.nil?
      respond_with = "I could not find anything in the genre #{genre.name}, try another genre?"
      @assistant.ask(respond_with, [respond_with])
    end
    @assistant.conversation.data['movie'] = movie.title

    respond_with = "How about #{movie.title}?"
    @assistant.ask(respond_with, [respond_with])
  end
end
