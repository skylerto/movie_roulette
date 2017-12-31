class TellMeMore
  def initialize(assistant)
    @assistant = assistant
  end

  def execute
    movie_title = @assistant.conversation.data['movie']
    movie = Movie.find(title: movie_title)
    @assistant.conversation.data['movie'] = movie.title
    respond_with = "What would you like to know more about? I know #{options movie}"
    @assistant.ask(respond_with, [respond_with])
  end

  def options(movie)
    data = ''
    movie.options.each_with_index do |opt, i|
      if i.eql?(movie.options.size - 1)
        data << "or #{clean opt}"
      else
        data << "#{clean opt}, "
      end
    end
    data
  end

  def clean(option)
    option.gsub('_', ' ')
  end
end
