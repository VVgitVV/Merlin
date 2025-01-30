class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @client = Client.new(name: "Placeholder Client")
    @project = Project.new(name: "Placeholder Project")
  end
end