ResquedPrince is a Resque worker that creates PDFs using [PrinceXML](http://www.princexml.com/).

# Usage

To start the worker: `QUEUE=resqued_prince bundle exec rake resque:worker`

Send jobs to the `resqued_prince` queue, with the following args:

  - `source_url` - the location from which the HTML will be downloaded
  - `destination_url` - where the PDF file will be sent. The PDF file is attached to the `file` parameter.

# Example

## Enqueuing

    Resque.enqueue_to('resqued_prince', 'PdfWorker', {source_url: "http://mydom.com/makemepdf", destination_url: "http://mydom.com/reports/1/update_file"})

## Upload to destination

After the PDF is created by the worker, it will be uploaded to the detination URL. Here's an example controller action in Ruby that accepts the file and saves it:

    def update_file
      report = Report.find(params[:id])
      report.file = params[:file]
      report.save
      # ...
    end
