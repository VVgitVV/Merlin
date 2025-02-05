class ClientsController < ApplicationController

  before_action :set_client, only: %i[edit update archive restore]


  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end




  def index
    # @clients = Client.active
    if params[:archived] == "true"
      @clients = Client.where(archived: true)
    else
      @clients = Client.where(archived: false)
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user

    if @client.save
      redirect_to clients_path, notice: 'Client was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end


  def update
    if @client.update(client_params)
      redirect_to client_path(@client), notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def archive
    @client.update(archived: true)
    redirect_to clients_path, notice: 'Client was archived successfully.'
  end

  def restore
    @client.update(archived: false)
    redirect_to clients_path, notice: 'Client was restored successfully.'
  end


  private

  def set_client
    @client = Client.find(params[:id])
  end



  def client_params
    params.require(:client).permit(:name, :description)

  end

end
