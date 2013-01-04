class HtmlToPdfMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    env = before_call(env)
    @app.call(env)
  end

  def before_call(env)
    FileUtils.mkdir_p('tmp')
    html_path = env[:html_path]
    html = File.read(html_path)
    env[:pdf_path] = TapaPrince.convert(html)
    env
  end

end
