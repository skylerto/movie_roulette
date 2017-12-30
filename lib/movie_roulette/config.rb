require 'themoviedb'
module Config
  @config = nil

  class << self
    def configure
      return true if self.configured?
      Tmdb::Api.key(load_api_key)
      @config = true
    end

    def configured?
      !@config.nil?
    end

    private

    def load_api_key
      ENV['MOVIEDB_API_KEY']
    end
  end
end
