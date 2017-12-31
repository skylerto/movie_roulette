class TellMeMore
  def initialize(assistant)
    @assistant = assistant
  end

  def execute
    movie_title = @assistant.conversation.data['movie']
    movie = Movie.find(title: movie_title)
    puts movie.inspect
    @assistant.conversation.data['movie'] = movie.title
    respond_with = "#{movie.overview}, how does that sound?"
    @assistant.ask(respond_with, [respond_with])
  end
end
