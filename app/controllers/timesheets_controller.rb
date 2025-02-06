require 'date'

class TimesheetsController < ApplicationController
  before_action :set_project, only: :create

  # def new
  #   @timesheet = Timesheet.new
  # end

  def index
    @timesheets = Timesheet.all.order(:created_at)
    @timesheet = Timesheet.new
  end

  def show
    @timesheet = Timesheet.find(params[:id])
    @timestamps = @timesheet.timestamps.where.not(end_time: nil).order(:end_time)
    @timestamp = Timestamp.new
    @invoice = @timesheet.invoice
  end

  def create
    @timesheet = Timesheet.new(project: @project)
    if @timesheet.save
      Invoice.create(timesheet: @timesheet)
      redirect_to client_project_timesheets_path(@client, @project)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:project_id])
  end

end
