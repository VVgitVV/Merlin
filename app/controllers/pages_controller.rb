class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @client = Client.new(name: "Placeholder Client")
    @project = Project.new(name: "Placeholder Project")
    @quote = Rails.cache.fetch('daily_quote', expires_in: 24.hours) do
      fetch_daily_quote
    end
  end

  private

  def fetch_daily_quote
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "user", content: "Give me an inspirational quote for the day on the subject of time, and show the name of the person it's attributed to." }],
        max_tokens: 50
      }
    )

    response.dig("choices", 0, "message", "content").strip
  end
end
