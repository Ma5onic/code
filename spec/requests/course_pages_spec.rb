require 'spec_helper'

describe "CoursePages" do
  
  subject { page }

  describe "course index page" do
		before { visit courses_path }

		it { should have_content('Courses') }
		it { should have_title(full_title('Courses')) }
	end

	describe "new course page" do

		before { visit courses_path }

		describe "as admin user" do
			
		end

		describe "as non-admin user" do
			it { should have_content('Courses') }
			it { should have_title(full_title('Courses')) }
		end		
	end
end
