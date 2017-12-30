class Movie
  attr_accessor :title, :overview
  def initialize(hash: nil)
    if hash
      @title = hash['title']
      @overview = hash['overview']
    end
  end

  def self.find(genre: nil, title: nil)
    if genre
      search = Tmdb::Search.new("/genre/#{genre.id}/movies")
      results = search.fetch
      res = []
      results.each { |r| res << Movie.new(hash: r) } if results
      return res
    elsif title
      movies = Tmdb::Movie.find(title.downcase)
      movie = Movie.new(hash: movies.first) unless movies.empty?
    end
  end
end
