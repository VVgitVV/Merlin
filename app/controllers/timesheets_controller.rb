require 'date'

class TimesheetsController < ApplicationController
  before_action :set_project, only: :create
  skip_before_action :authenticate_user!, only: %i[show generate_pdf]

  def index
    @timesheets = Timesheet.all.order(:created_at)
    @timesheet = Timesheet.new
  end

  def show
    @timesheet = Timesheet.find(params[:id])
    @timestamps = @timesheet.timestamps.where.not(end_time: nil).order(:end_time)
    @timestamp = Timestamp.new
  end

  def create
    @timesheet = Timesheet.new(project: @project)
    if @timesheet.save
      redirect_to client_project_timesheets_path(@client, @project)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def generate_pdf
    @timesheet = Timesheet.find(params[:id])
    use_docraptor(@timesheet)
  end

  private

  def set_project
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:project_id])
  end

  def use_docraptor(timesheet)
    require "docraptor"

    DocRaptor.configure do |config|
      config.username = "YOUR_API_KEY_HERE" # this key works in test mode!
    end

    docraptor = DocRaptor::DocApi.new

    begin
      response = docraptor.create_doc(
        test: true, # test documents are free but watermarked
        document_type: "pdf",
        document_url: "https://www.lancelot.quest/clients/#{timesheet.project.client.id}/projects/#{timesheet.project.id}/timesheets/#{timesheet.id}"
      )

      # create_doc() returns a binary string
      File.write("Timesheet_#{timesheet.id}.pdf", response, mode: "wb")
      puts "Successfully created docraptor-hello.pdf!"
    rescue DocRaptor::ApiError => error
      puts "#{error.class}: #{error.message}"
      puts error.code
      puts error.response_body
      puts error.backtrace[0..3].join("\n")
    end
  end
end
