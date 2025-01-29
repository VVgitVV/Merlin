class TimestampsController < ApplicationController
  # make methods here like calculate_date
  def index
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.new
  end

  def create
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.new
    @timestamp.timesheet = @timesheet
    @timestamp.start_time = DateTime.now
    render :new, status: :unprocessable_entity unless @timestamp.save
    # if @timestamp.save
    #   redirect_to client_project_timesheet_timestamps_path
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end
end
