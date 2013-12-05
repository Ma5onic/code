namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_admin
    make_course_creator
  end
end

def make_admin
  admin = User.create!(name: "Tim", email: "timgreen1@outlook.com",
                       username: "admin", password: "password123", 
                       password_confirmation: "password123", admin: true, 
                       location: "Leeds, UK", course_creator: true)
end

def make_course_creator
  course_creator = User.create!(name: "", email: "test@example.com",
                                username: "creator", password: "password",
                                password_confirmation: "password", admin: false,
                                location: "UK", course_creator: true)
end