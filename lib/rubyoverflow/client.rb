module Rubyoverflow
  class Client
    HOST = 'http://api.stackexchange.com'
    VERSION = '2.0'
    SITE = 'stackoverflow'

    attr_accessor :api_key

    def initialize(options = {})
        @version = options[:version] || VERSION
        @api_key = options[:api_key] if options[:api_key]
    end

    def request(path, parameters = {})
      conn = Faraday.new(:url => "#{HOST}/#{@version}") do |builder|
        builder.request  :url_encoded
        builder.request  :json
        builder.adapter  :net_http
      end
      unless path == '/sites'
        parameters[:site] = SITE if parameters[:site].nil? || parameters[:site].empty?
      end
      parameters[:key] = @api_key unless @api_key.nil? || @api_key.empty?
      parameters['Accept-Encoding'] = 'gzip'
      response = conn.get do |req|
        req.url normalize(path), parameters
      end
      rep_string = response.body
      begin
        gz = Zlib::GzipReader.new(StringIO.new(response.body.to_s))
        rep_string = gz.read
      rescue Zlib::GzipFile::Error
      end
      return JSON.parse(rep_string), response.env[:url]
    end

    private

    def normalize(path)
      path.end_with?('/') ? path : path + '/'
    end
  end
end
