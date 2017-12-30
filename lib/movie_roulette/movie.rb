class Movie
  attr_accessor :title, :description
  def initialize(hash: nil)
    if hash
      @title = hash['title']
      @description = hash['overview']
    end
  end

  def self.find(genre: nil, title: nil)
    if genre
      search = Tmdb::Search.new("/genre/#{genre.id}/movies")
      results = search.fetch
      res = []
      puts results
      results.each { |r| res << Movie.new(hash: r) } if results
      return res
    elsif title
      movies = Tmdb::Movie.find(title.downcase)
      movie = Movie.new(hash: movies.first) if movies
    end
  end
end
