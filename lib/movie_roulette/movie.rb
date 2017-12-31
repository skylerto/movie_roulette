class Movie < Tmdb::Movie
  attr_accessor :title, :overview
  def initialize(hash: nil, movie: nil)
    if hash
      @title = hash['title']
      @overview = hash['overview']
    elsif movie
      @movie = movie
      @title = movie.title
      @overview = movie.overview
    end
  end

  def option(option)
    @movie.send(option.to_sym)
  end

  def method_missing(method, *args, &block)
    @movie.send(method, *args, &block) if @movie
  end

  def options
    @movie.instance_variables.map { |i| i.to_s.gsub(':', '').gsub('@', '') }
  end

  def self.find(genre: nil, title: nil)
    if genre
      search = Tmdb::Search.new("/genre/#{genre.id}/movies")
      results = search.fetch
      res = []
      results.each { |r| res << Movie.new(hash: r) } if results
      return res
    elsif title
      movie = Tmdb::Movie.find(title.downcase)
      movie = movie.first unless movie.empty?
      movie = Movie.new(movie: movie) if movie
    end
  end
end
