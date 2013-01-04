class UploadMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    env = before_call(env)
    @app.call(env)
  end

  def before_call(env)
    response = HTTMultiParty.post(
      env[:destination_url],
      :query => {:file => env[:pdf_path]}
    )
    env.merge(:upload_status => response.code)
  end

end
