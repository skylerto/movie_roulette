require "spec_helper"
# require_relative "../lib/movie_roulette/genre"

RSpec.describe Genre do
  it "Should create a genre from a hash" do
    hash = {}
    hash['id'] = 1
    hash['name'] = 'meri'

    genre = Genre.new(hash: hash)

    expect(genre.id).to eq 1
    expect(genre.name).to eq 'meri'
  end

  it 'should grab a list of all genres' do
    expect(Genre.list).not_to be nil
  end

  it 'should find a genre' do
    genre_query = 'action'
    genre = Genre.find name: genre_query
    expect(genre.id).to eq 28
    expect(genre.name).to eq 'Action'
  end
end
