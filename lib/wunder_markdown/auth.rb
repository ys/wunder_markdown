require 'netrc'

module WunderMarkdown
  API_ENDPOINT = 'api.wunderlist.com'
  class Auth
    def initialize
      @netrc = Netrc.read
    end

    def save(user, password)
      @netrc[API_ENDPOINT] = user, password
      @netrc.save
      password
    end

    def get
      _, token = @netrc[API_ENDPOINT]
      token
    end
  end
end
