class TimestampsController < ApplicationController
  before_action :set_chained_instances

  def index
    @timestamp = Timestamp.new
  end

  def create
    @timestamp = Timestamp.new
    @timestamp.timesheet = @timesheet
    @timestamp.start_time = DateTime.now
    if @timestamp.save
      redirect_to client_project_timesheet_timestamps_path(@client, @project, @timesheet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def stop
    @timestamp = Timestamp.find(params[:id])
    @timestamp.update(end_time: DateTime.now)
    redirect_to client_project_timesheet_timestamps_path(@client, @project, @timesheet)
  end

  def edit
    @timestamp = Timestamp.find(params[:id])
  end

  def update
    @timestamp = Timestamp.find(params[:id])
    @timestamp.update(timestamp_params)
    redirect_to client_project_timesheet_timestamps_path(@client, @project, @timesheet)
  end

  private

  def set_chained_instances
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
  end

  def timestamp_params
    params.require(:timestamp).permit(:task_description)
  end
end
