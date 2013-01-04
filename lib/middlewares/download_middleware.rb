require 'securerandom'

class DownloadMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    response = HTTParty.get(env[:source_url])
    FileUtils.mkdir_p('tmp')

    random_str = ::SecureRandom.hex(16)
    file_path = File.join("tmp", "source_#{random_str}.html")

    File.open(file_path, 'w') do |f|
      f.puts response.body
    end

    env[:html_path] = file_path

    @app.call(env)
  end

end
