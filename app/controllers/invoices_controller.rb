class InvoicesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show generate_pdf]

  def show
    @user = "#{current_user.first_name} #{current_user.last_name}"
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamps = @timesheet.timestamps.where.not(end_time: nil).order(:end_time)
    @invoice = Invoice.find(params[:id])
    @project = @timesheet.project
    @client = @project.client
  end

  def generate_pdf
    @timesheet = Timesheet.find(params[:timesheet_id])
    @invoice = Invoice.find(params[:id])
    use_docraptor(@timesheet, @invoice)
  end

  private

  def use_docraptor(timesheet, invoice)
    require "docraptor"

    DocRaptor.configure do |config|
      config.username = "YOUR_API_KEY_HERE" # this key works in test mode!
    end

    docraptor = DocRaptor::DocApi.new

    begin
      response = docraptor.create_doc(
        test: true, # test documents are free but watermarked
        document_type: "pdf",
        # document_url: "https://www.lancelot.quest/timesheets/#{timesheet.id}/invoices/#{invoice.id}"
        # test
        document_url: "https://www.lancelot.quest/"
      )

      # create_doc() returns a binary string
      File.write("Invoice_#{invoice.id}.pdf", response, mode: "wb")
      puts "Successfully created docraptor-hello.pdf!"
    rescue DocRaptor::ApiError => error
      puts "#{error.class}: #{error.message}"
      puts error.code
      puts error.response_body
      puts error.backtrace[0..3].join("\n")
    end
  end
end
