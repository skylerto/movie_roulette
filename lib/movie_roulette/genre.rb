require 'themoviedb'

class Genre
  attr_accessor :id, :name

  def initialize(id: nil, name: nil, hash: nil)
    @id = id
    @name = name
    if hash
      @id = hash['id'] if hash['id']
      @name = hash['name'] if hash['name']
    end
  end

  def self.list
    Tmdb::Genre.list if Config.configure
  end

  def self.find(name: nil, id: nil)
    genres = self.list['genres']
    found = if name
      genres.select { |g| g['name'].downcase.eql?(name.downcase) }
    else
      genres.select { |g| g['id'].eql?(id) }
    end
    return Genre.new(hash: found.first) if found
  end
end
