class CoursesController < ApplicationController
	before_action :admin_user, only: [:new, :create, :destroy]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.save
      flash[:success] = "Course created!"
      redirect_to courses_url
    else
      render 'new'
    end
  end

  def index
  	@courses = Course.all.sort_by! { |c| c.name.downcase }
  end

  def show
    @course = Course.find_by_permalink(params[:permalink])
  end

  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "Course successfully deleted."
    redirect_to courses_url
  end

  private

  	def admin_user
			redirect_to courses_url, notice: "You do not have the correct privileges to access this page" unless current_user.admin?
		end

    def course_params
      params.require(:course).permit(:name, :description, :permalink)
    end
end
