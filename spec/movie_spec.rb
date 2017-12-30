require "spec_helper"

RSpec.describe Movie do
  it 'should grab a list of movies via a genre' do
    genre = Genre.find name: 'action'
    expect(Movie.find(genre: genre)).not_to be nil
  end

  it 'should grab a movie based on the title' do
    movie = Movie.find title: 'san andres'
    byebug
    expect(movie).not_to be nil
  end
end
