namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_admin
  end
end

def make_admin
  admin = User.create!(name: "Tim", email: "timgreen1@outlook.com",
                       username: "admin", password: "password123", 
                       password_confirmation: "password123", admin: true, location: "Leeds, UK")
end