require 'faker'

# Clear existing data
Timestamp.destroy_all
Timesheet.destroy_all
Project.destroy_all
Client.destroy_all
User.destroy_all

# Create a user
user = User.create!(
  email: "developer@example.com",
  password: "password123", # Replace this with secure password handling
  username: "freelance_dev",
  first_name: "John",
  last_name: "Doe"
)

# Client names as requested
client_names = ["Percy", "Logan", "Vanessa", "Carter", "Rebecca"]

# Define project names per client
project_names = [
  ["Mobile App Development", "Cloud Migration", "Data Analytics Setup", "Website SEO Optimization", "Backend API Development"],
  ["Social Media Dashboard", "Online Marketplace", "User Authentication System", "AI Chatbot Integration", "Cybersecurity Enhancement"],
  ["E-learning Platform", "E-commerce Redesign", "HR Management System", "Real Estate Listings", "Automated Booking System"],
  ["Financial Forecasting Tool", "Stock Trading App", "Enterprise CRM System", "Healthcare Patient Portal", "Freelancer Time Tracking App"],
  ["Smart Home Automation", "Video Streaming Platform", "Gaming API Development", "AR Shopping Experience", "Digital Marketing Suite"]
]

# Create Clients & Projects
clients = []

client_names.each_with_index do |name, index|
  client = Client.new(
    name: name,
    description: "Client #{name} specializes in #{Faker::Company.industry}.",
    user: user
  )

  if client.save
    puts "✅ Created Client: #{client.name}"
  else
    puts "❌ Failed to create Client: #{client.name}"
    puts client.errors.full_messages # 🔍 Print errors if save fails
  end
  clients << client

  # Create 5 projects for each client
  project_names[index].each do |project_name|
    project = Project.create!(
      name: project_name,
      aim: Faker::Lorem.sentence(word_count: 10),
      hourly_rate: rand(40..100), # Random hourly rate between $40-$100
      completed: [true, false].sample,
      client: client
    )

    # Create 3 timesheets for each project
    3.times do
      start_date = Faker::Date.backward(days: rand(30..90))
      end_date = start_date + rand(7..30) # Timesheets can last from 1 week to 1 month
      timesheet = Timesheet.create!(
        # start_date: start_date,
        # end_date: end_date,
        project: project
      )

      # Create 5 timestamps per timesheet
      5.times do
        start_time = Faker::Time.between(from: start_date, to: end_date).to_time
        end_time = start_time + rand(1..5) * 3600 # Work sessions last between 1-5 hours
        Timestamp.create!(
          start_time: start_time,
          end_time: end_time,
          task_description: Faker::Hacker.say_something_smart,
          timesheet: timesheet
        )
      end
    end
  end
end

puts "✅ Seeding completed successfully!"
puts "📌 Created #{User.count} user"
puts "📌 Created #{Client.count} clients"
puts "📌 Created #{Project.count} projects"
puts "📌 Created #{Timesheet.count} timesheets"
puts "📌 Created #{Timestamp.count} timestamps"
puts "📌 All data is associated correctly"
