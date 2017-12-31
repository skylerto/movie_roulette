class TellMeAbout
  def initialize(assistant)
    @assistant = assistant
  end

  def execute
    movie_title = @assistant.conversation.data['movie']
    @assistant.conversation.data['movie'] = movie_title
    puts "Looking up #{movie_title}"
    movie = Movie.find(title: movie_title)
    method = @assistant.arguments[0].text_value.downcase.gsub(' ', '_')
    if movie.options.include?(method)
      puts "Attempting #{method} on #{movie.inspect}"
      res = movie.send(method.to_sym)
      respond_with = "#{res}, how does that sound?"
      return @assistant.ask(respond_with, [respond_with])
    else
      return @assistant.tell('Lets try again later')
    end
  end
end
