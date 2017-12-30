class Movie
  attr_accessor :title
  def initialize(hash: nil)
    if hash
      @title = hash['title']
    end
  end

  def self.find(genre: genre)
    search = Tmdb::Search.new("/genre/#{genre.id}/movies")
    results = search.fetch
    res = []
    puts results
    results.each { |r| res << Movie.new(hash: r) } if results
    res
  end
end
