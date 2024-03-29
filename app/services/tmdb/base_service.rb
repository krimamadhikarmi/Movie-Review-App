require 'uri'
require 'net/http'


module Tmdb
class BaseService
    API_KEY = ENV["TMDB"]
    def get_request(url:)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        request["Authorization"] = "Bearer #{API_KEY}"

        response = http.request(request)
    end
end
end
