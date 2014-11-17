class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  @@Q_CLIENT_ID = ENV['QIITA_CLIENT_ID']
  @@Q_CLIENT_SECRET = ENV['QIITA_CLIENT_SECRET']
  @@Q_STATE = ENV['QIITA_STATE']
  @@G_CLIENT_ID = ENV['GITHUB_CLIENT_ID']
  @@G_CLIENT_SECRET = ENV['GITHUB_CLIENT_SECRET']

  def qiita_token(code)
    connect('POST',
            'https://qiita.com',
            '/api/v2/access_tokens',
            {'Content-Type' => 'application/json'},
            {client_id: @@Q_CLIENT_ID, client_secret: @@Q_CLIENT_SECRET, code: code})
  end

  def qiita_user(token)
    connect('GET',
            'https://qiita.com',
            '/api/v2/authenticated_user',
            {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{token}"},
            nil)
  end

  def github_token(code)
    connect('POST',
            'https://github.com',
            '/login/oauth/access_token',
            {'Content-Type' => 'application/json', 'Accept'=> 'application/json'},
            {client_id: @@G_CLIENT_ID, client_secret: @@G_CLIENT_SECRET, code: code})
  end

  def github_user(token)
    connect('GET',
            'https://api.github.com',
            '/user',
            {'Content-Type' => 'application/json', 'Authorization'=> "token #{token}"},
            nil)
  end

  private

    def connect(method, url, path, header, param = nil)

      conn = Faraday::Connection.new(url: url) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Logger
        builder.use Faraday::Adapter::NetHttp
      end

      if method.upcase == "POST"
        response = conn.post do |request|
          request.url path
          request.headers = header
          request.body = JSON.generate(param) if param
        end
      else
        response = conn.get do |request|
          request.url path
          request.headers = header
          request.body = JSON.generate(param) if param
        end
      end

      JSON.parser.new(response.body).parse
    end
end
