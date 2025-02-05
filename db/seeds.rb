puts "Cleaning database"

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
    client.projects.create!(project_data)
  end
end

puts "Seed data successfully created!"
