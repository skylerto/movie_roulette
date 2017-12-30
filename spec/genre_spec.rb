require "spec_helper"
require_relative "../lib/movie_roulette/genre"

RSpec.describe Genre do
  it "Should create a genre from a hash" do
    hash = {}
    hash['id'] = 1
    hash['name'] = 'meri'

    genre = Genre.new(hash: hash)

    expect(genre.id).to eq 1
    expect(genre.name).to eq 'meri'
  end
end
