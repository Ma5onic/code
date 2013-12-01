class CoursesController < ApplicationController
	before_action :admin_user, only: :new

  def new
  end

  def index
  	@courses = Course.all
  end

  private

  	def admin_user
			redirect_to courses_url, notice: "You do not have the correct privileges to access this page" unless current_user.admin?
		end
end
