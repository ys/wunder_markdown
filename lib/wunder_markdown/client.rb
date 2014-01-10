require 'faraday'
require 'json'
require 'wunder_markdown/task'
require 'wunder_markdown/list'

module WunderMarkdown
  class Client
    API_ENDPOINT = 'api.wunderlist.com'
    API_URL = "https://#{API_ENDPOINT}"
    attr_accessor :token, :conn

    def initialize(token = nil)
      @token = token
      @conn = Faraday.new(:url => API_URL)
    end

    def login(email, password)
      login_response = conn.post do |req|
        req.url '/login'
        req.headers['Content-Type'] = 'application/json'
        req.body = '{ "email": "'+ email +'", "password": "'+ password +'"}'
      end
      @token = JSON.parse(login_response.body)['token']
      [email, @token]
    end

    def lists
      @lists ||= get('me/lists')
    end

    def list(list_name)
      json = lists.detect { |l| l['title'] == list_name }
      List.new(json['id'], json['title'])
    end

    def tasks(list)
      json = get("#{list.id}/tasks")
      json.map do |task_json|
        if task_json['completed_at'] == nil
          Task.new(task_json['id'], task_json['title'], task_json['note'], task_json['parent_id'])
        end
      end.compact
    end

    def get(url)
      response = conn.get do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = token
      end
      JSON.parse(response.body)
    end
  end
end
