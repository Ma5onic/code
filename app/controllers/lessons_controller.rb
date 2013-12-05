class LessonsController < ApplicationController
	before_action :authorized_user, only: [:new, :create, :edit, :update]
  before_action :admin_user,      only: :destroy
  
  def new
  	@lesson = Lesson.new
    @track = Track.find_by_permalink(params[:permalink])
    @course = Course.find(@track.course_id)
  end

  def create
    @track = Track.find_by_permalink(params[:permalink])
    @lesson = @track.lessons.create(lesson_params)
    if @track.save
      flash[:success] = "Lesson '#{@lesson.name}' created!"
      redirect_to courses_url
    else
      render 'new'
    end
  end

  def show
  	@lesson = Lesson.find_by_permalink(params[:permalink])
    @track = Track.find(@lesson.track_id)
    @course = Course.find(@track.course_id)
    @creator = User.find(@course.user_id)
  end

  def edit
    @lesson = Lesson.find_by_permalink(params[:permalink])
    @track = Track.find(@lesson.track_id)
    @course = Course.find(@track.course_id)
  end

  def update
    @lesson = Lesson.find_by_permalink(params[:permalink])
    @track = Track.find(@lesson.track_id)
    if @lesson.update_attributes(lesson_params)
      flash[:success] = "Lesson updated successfully"
      redirect_to lesson_path @lesson
    else
      render 'edit'
    end
  end

  def destroy
    Lesson.find_by_permalink(params[:permalink]).destroy
    flash[:success] = "Lesson successfully deleted."
    redirect_to courses_url
  end

  def index
  	@track = Track.find_by_permalink(params[:permalink])
  	@lessons = @track.lessons.all.sort_by! { |c| c.lesson_order }
    @course = Course.find(@track.course_id)
  end

  private

  	def authorized_user
      if current_user.admin? || current_user.course_creator?
      else
       redirect_to courses_url, notice: "You do not have the correct privileges to access this page"
      end
    end

    def admin_user
      redirect_to courses_url, notice: "You do not have the correct privileges to access this page" unless current_user.admin?
    end

    def lesson_params
      params.require(:lesson).permit(:name, :content, :starting_content, 
                                     :instructions, :hints, :order, :permalink)
    end
end
