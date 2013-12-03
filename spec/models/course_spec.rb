require 'spec_helper'

describe Course do
  before do
  	@course = Course.new(name: "Ruby on Rails", 
  										   description: "A powerful web framework designed to make database-driven websites with ease.")
  end 

  subject { @course }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

  it { should be_valid }

  describe "when description is not present" do
  	before { @course.description = " " }
  	it { should_not be_valid }
  end

  describe "when name is not present" do
  	before { @course.name = " " }
  	it { should_not be_valid }
  end

  describe "when description is too long" do
  	before { @course.description = "a" * 201 }
  	it { should_not be_valid }
  end

  describe "when name contains spaces" do
  	it "permalink should have dashes" do
  		before { @course.save }
  		expect(@course.permalink).to include("ruby-on-rails")
  	end
  end

  describe "when course name is already taken" do
    before do
      course_with_same_name = @course.dup
      course_with_same_name.name = @course.name.upcase
      course_with_same_name.save
    end

    it { should_not be_valid }
  end
end
