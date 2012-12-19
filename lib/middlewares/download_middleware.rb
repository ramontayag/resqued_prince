class DownloadMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    response = HTTParty.get(env[:source_url])
    response.body
  end

end
