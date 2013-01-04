class PdfWorker

  @queue = :resqued_prince

  def self.process(args)
    self.stack.call(args)
  end

  def self.stack
    s = Middleware::Builder.new
    s.use DownloadMiddleware
    s.use HtmlToPdfMiddleware
    s.use UploadMiddleware
    s
  end

end
