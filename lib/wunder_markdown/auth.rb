require 'netrc'

module WunderMarkdown
  API_ENDPOINT = 'api.wunderlist.com'
  class Auth
    def initialize
      @netrc = Netrc.read
    end

    def save(*args)
      @netrc[API_ENDPOINT] = args
      @netrc.save
      args[1]
    end

    def get
      _, token = @netrc[API_ENDPOINT]
      token
    end
  end
end
