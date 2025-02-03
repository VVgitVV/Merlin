class ProjectsController < ApplicationController
  before_action :set_client
  before_action :set_project, only: [:show, :edit, :update, :archive, :restore]

  def index
    if @client
      # @projects = @client.projects.active
      if params[:archived] == "true"
        @projects = @client.projects.where(archived: true)
      else
        @projects = @client.projects.where(archived: false)
      end
      render :index_for_client
    else
      if params[:archived] == "true"
        @projects = Project.where(archived: true)
      else
        @projects = Project.where(archived: false)
      end
      render :index
    end
  end

  def show
    # @project is set using set_project
  end

  def new
    @project = @client.projects.new
  end

  def create
    @project = @client.projects.new(project_params)
    if @project.save
      #create timesheet
      redirect_to client_project_path(@client, @project),
                  notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def archive
    @project = Project.find(params[:id])
    @project.update(archived: true)
    redirect_to client_projects_path(@project.client), notice: 'Project was successfully archived.'
  end

  def restore
    @project.update(archived: false)
    redirect_to client_projects_path(@client), notice: 'Project was restored successfully.'
  end

  private

  def set_client
    @client = Client.find(params[:client_id]) if params[:client_id].present?
  end

  def set_project
    @project = @client.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :aim, :hourly_rate)
  end
end
