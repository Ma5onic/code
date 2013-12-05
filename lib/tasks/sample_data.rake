namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_admin
    make_course_creator
    make_user
  end
end

def make_admin
  admin = User.create!(name: "Tim", email: "timgreen1@outlook.com",
                       username: "admin", password: "password123", 
                       password_confirmation: "password123", admin: true, 
                       location: "Leeds, UK", course_creator: true)
end

def make_course_creator
  course_creator = User.create!(username: "creator", email: "test@example.com",
                                password: "password", password_confirmation: "password", 
                                admin: false, location: "UK", course_creator: true)
end

def make_user
  user = User.create!(username: 'user', email: 'user@example.com', password: 'password',
                      password_confirmation: 'password')
end