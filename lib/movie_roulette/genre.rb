class Genre
  attr_accessor :id, :name

  def initailize(id:, name:, hash: nil)
    @id = id
    @name = name
    if hash
      @id = hash['id']
      @name = hash['name']
    end
  end
end
