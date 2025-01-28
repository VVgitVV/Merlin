# Clear existing data
Timestamp.destroy_all
Timesheet.destroy_all
Project.destroy_all
Client.destroy_all
User.destroy_all

# Create a user
user = User.create!(
  email: "developer@example.com",
  password: "password123", # Replace this with proper password handling in your app
  username: "freelance_dev",
  first_name: "John",
  last_name: "Doe"
)

# Create clients
client1 = Client.create!(
  name: "Tech Solutions Inc.",
  description: "A technology consulting firm.",
  user: user
)

client2 = Client.create!(
  name: "Creative Designs Co.",
  description: "A graphic and web design agency.",
  user: user
)

# Create projects for client1
project1_client1 = Project.create!(
  name: "Website Revamp",
  aim: "Redesign the company website with modern UX/UI principles.",
  hourly_rate: 50.0,
  completed: false,
  client: client1
)

project2_client1 = Project.create!(
  name: "CRM Integration",
  aim: "Integrate a customer relationship management system.",
  hourly_rate: 55.0,
  completed: false,
  client: client1
)

# Create projects for client2
project1_client2 = Project.create!(
  name: "E-commerce Platform",
  aim: "Build an online store for the client.",
  hourly_rate: 60.0,
  completed: false,
  client: client2
)

project2_client2 = Project.create!(
  name: "Marketing Website",
  aim: "Develop a marketing website to promote the client’s services.",
  hourly_rate: 45.0,
  completed: false,
  client: client2
)

puts "Seeding completed successfully!"
