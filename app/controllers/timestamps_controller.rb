class TimestampsController < ApplicationController
  before_action :set_chained_instances
  def show
    @timestamp = Timestamp.find(params[:id])
    if @client
      render :linked_show
    else
      render :show
    end
  end

  def new
    @timestamp = Timestamp.new
    if @client
      render :linked_new
    else
      render :new
    end
  end

  def create
    if @client
      @timestamp = Timestamp.new
      # render :linked_show
      @timestamp.timesheet = @timesheet
      @timestamp.start_time = DateTime.now
      if @timestamp.save
        redirect_to client_project_timesheet_timestamp_path(@client, @project, @timesheet, @timestamp)
      else
        render :new, status: :unprocessable_entity
      end
    else
      @timestamp = Timestamp.new(timestamp_params)
      @timesheet = Timesheet.find(params[:timesheet_id])
      # @project = Project.find(@timesheet)
      # @timestamp.project = @project
      @timestamp.timesheet = @timesheet
      raise
      @timestamp.start_time = DateTime.now
      if @timestamp.save
        redirect_to timestamp_path(@timestamp)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def stop
    @timestamp = Timestamp.find(params[:id])
    @timestamp.update(end_time: DateTime.now)
    redirect_to new_client_project_timesheet_timestamp_path(@client, @project, @timesheet)
  end

  def edit
    @timestamp = Timestamp.find(params[:id])
  end

  def update
    @timestamp = Timestamp.find(params[:id])
    @timestamp.update(linked_timestamp_params)
    redirect_to client_project_timesheet_timestamp_path(@client, @project, @timesheet, @timestamp)
  end

  private

  def set_chained_instances
    @client = Client.find(params[:client_id]) if params[:client_id]
    @project = Project.find(params[:project_id]) if params[:project_id]
    @timesheet = Timesheet.find(params[:timesheet_id]) if params[:timesheet_id]
  end

  def timestamp_params
    params.require(:timestamp).permit(:timesheet)
  end

  def linked_timestamp_params
    params.require(:timestamp).permit(:task_description)
  end
end
