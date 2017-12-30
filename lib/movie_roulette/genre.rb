class Genre
  attr_accessor :id, :name

  def initialize(id: nil, name: nil, hash: nil)
    @id = id
    @name = name
    if hash
      @id = hash['id']
      @name = hash['name']
    end
  end
end
