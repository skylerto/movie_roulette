class TellMeAbout
  def initialize(assistant)
    @assistant = assistant
  end

  def execute
    movie_title = @assistant.conversation.data['movie']
    movie = Movie.find(title: movie_title)
    @assistant.conversation.data['movie'] = movie.title
    method = @assistant.arguments[0].text_value.downcase.gsub(' ', '_')
    if movie.options.include?(method)
      res = movie.send("@#{method}".to_s)
      respond_with = "#{res}, how does that sound?"
      @assistant.ask(respond_with, [respond_with])
    else
      assistant.tell('Lets try again later')
    end
  end
end
