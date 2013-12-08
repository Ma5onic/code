namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_admin
    make_course_creator
    make_user
    make_courses
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
                                admin: false, location: "UK", course_creator: true, name: "Ben")
end

def make_user
  user = User.create!(username: 'user', email: 'user@example.com', password: 'password',
                      password_confirmation: 'password')
end

def make_courses
  course1 = Course.create!(name: 'HTML', 
                           description: 'HyperText Markup Language (HTML) is the main markup language for creating web pages and other information that can be displayed in a web browser.',
                           user_id: 1)
  course2 = Course.create!(name: 'Python', 
                           description: 'Python is a widely used general-purpose, high-level programming language. Its design philosophy emphasizes code readability, and its syntax allows programmers to express concepts in fewer lines of code than in other languages such as Ruby.',
                           user_id: 2)
  track1 = Track.create!(name: 'Introduction to HTML',
                         description: 'This track will teach you the basics of HTML, what goes into a HTML webpage and how to structure a HTML document.',
                         course_id: course1.id,
                         user_id: 1,
                         order: 1)
  track2 = Track.create!(name: 'HTML the 5\'th',
                         description: 'This track will teach you HTML5 and how to effectively use HTML5 tags.',
                         course_id: course1.id,
                         user_id: 1,
                         order: 2)
  track3 = Track.create!(name: 'Python Basics',
                         description: 'This track will teach you the basics of python.',
                         course_id: course2.id,
                         user_id: 2,
                         order: 1)
  lesson1 = Lesson.create!(name: 'Python: What you will Learn',
                           content: 'These are some of the things you will learn about in the upcoming lessons.',
                           instructions: 'Read through the code on the left and press Submit when you are ready.',
                           hints: "",
                           track_id: track3.id,
                           order: 1,
                           starting_content: '""" 
This is a comment
it wont be read by the computer
"""
# This is also a comment the # is when the comment is 1 line long.

my_varible = "Hello!"
print my_varible
',
                           user_id: 2)
  lesson2 = Lesson.create!(name: 'Python Comments',
                           content: "This lesson is going to teach you all about comments. There are two types of comments but they both have the same purpose. A comment isn't read by the computer and normally contain notes for other human to read.\n\nWhen writing a program it is important to remember that programs are written for humans, not computers. Comments should be written near all lines of code that does not explicitly explain itself. This will ensure that anyone else who reads your code can understand the flow of the program. After visiting past code a few months later even you may find it alien.\n\nA single line comment has a '#' at the start of the line. A multi-line comment has three \" at the beginning at three at the end.",
                           instructions: 'Make your own single-line and multi-line comment saying whatever you want.',
                           hints: "Remember you can use \"\"\" for a multi-line comment or a # for a single line comment.",
                           track_id: track3.id,
                           order: 2,
                           starting_content: '"""
This is a multi line comment, they are used when 
the message takes up more than one line.
"""

# This is a single line comment, used when you are quickly describing somthing
',
                           user_id: 2)
  lesson3 = Lesson.create!(name: "HTML Structure",
                           content: "Every webpage you look at is written in a language called HTML. You can think of HTML as the skeleton that gives every webpage structure. In this course, we'll use HTML to add paragraphs, headings, images and links to a webpage.\n\nIn the editor to the left, there's a HTML file. This is the window we'll type our HTML into. See the code with the <>s? That's HTML! Like any language, it has its own special syntax (rules for communicating).\n\nThroughout this track you will learn what each of the tags (the things with <> outside them) mean and how to properly user them. Press 'Submit Code' to get started!",
                           instructions: "Read the code to the left then hit 'Submit Code'",
                           hints: "",
                           track_id: track1.id,
                           order: 1,
                           starting_content: '<!DOCTYPE html>
<html>
  <head>
    <title>My First Webpage</title>
  </head>
  <body>
    <h1>This is the Heading!</h1>
    <h3>This is a sub-heading</h3>
    <p>This is a paragraph to go under the heading, it can be as long or as short as you want.</p>
  </body>
</html>
',
                           user_id: 1)
end