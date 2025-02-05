puts "Cleaning database"

Question.destroy_all
Invoice.destroy_all
Timestamp.destroy_all
Timesheet.destroy_all
Project.destroy_all
Client.destroy_all
User.destroy_all

user = User.create!(
  first_name: "Guinevere",
  last_name: "Jones",
  username: "guinevere",
  email: "guinevere@arthurian.com",
  password: "password123",
  password_confirmation: "password123"
)

clients_data = [
  { name: "Acme Corp", description: "A large e-commerce platform looking for a full-stack web solution." },
  { name: "BetaSoft", description: "A SaaS startup needing a custom dashboard and API integration." },
  { name: "Gamma Designs", description: "A creative agency requiring a portfolio and client management system." }
]

clients = clients_data.map do |client_data|
  user.clients.create!(client_data)
end

projects_data = [
  [
    { name: "E-Commerce Storefront", aim: "Develop a modern, responsive online store.", hourly_rate: 75.0 },
    { name: "Payment Gateway Integration", aim: "Implement Stripe and PayPal for seamless transactions.", hourly_rate: 80.0 },
    { name: "Admin Dashboard", aim: "Create an admin panel for managing inventory and users.", hourly_rate: 85.0 }
  ],
  [
    { name: "SaaS Dashboard", aim: "Build an interactive analytics dashboard.", hourly_rate: 90.0 },
    { name: "API Development", aim: "Develop a RESTful API for third-party integrations.", hourly_rate: 95.0 },
    { name: "User Authentication", aim: "Implement secure authentication with OAuth and JWT.", hourly_rate: 85.0 }
  ],
  [
    { name: "Portfolio Website", aim: "Create a visually stunning portfolio site.", hourly_rate: 70.0 },
    { name: "Client CRM", aim: "Develop a lightweight CRM to manage clients and leads.", hourly_rate: 80.0 },
    { name: "Blog Engine", aim: "Build a custom blog system with CMS features.", hourly_rate: 75.0 }
  ]
]

clients.each_with_index do |client, index|
  projects_data[index].each do |project_data|
    project = client.projects.create!(project_data)

    # Create a timesheet for the project
    timesheet = Timesheet.create!(project: project)

    # Create 5 timestamps for the timesheet with random durations and unique task descriptions
    5.times do
      # Generate random start and end times with different durations
      start_time = DateTime.now.beginning_of_day + rand(1..6).hours + rand(0..59).minutes
      duration = rand(30..180)  # Duration between 30 minutes and 3 hours
      end_time = start_time + (duration / 60.0).hours

      # Unique task description
      task_descriptions = [
        "Initial setup and configuration",
        "API integration and testing",
        "UI/UX design improvements",
        "Database schema migration",
        "Bug fixing and optimization"
      ]
      task_description = task_descriptions.sample

      Timestamp.create!(
        timesheet: timesheet,
        start_time: start_time,
        end_time: end_time,
        task_description: task_description
      )
    end
  end
end

puts "Seed data successfully created!"
