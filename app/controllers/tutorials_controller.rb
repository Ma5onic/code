class TutorialsController < ApplicationController
	before_action :authorized_user, only: [:new, :create, :edit, :update, :destroy]

  def new
  	@tutorial = Tutorial.new
  	@track = Track.find_by_permalink(params[:permalink])
  	@course = Course.find(@track.course_id)
  end

  def create
    @track = Track.find_by_permalink(params[:permalink])
    @tutorial = current_user.tutorials.build(tutorial_params)
    @course = Course.find(@track.course_id)
    if @tutorial.save
      flash[:success] = "Tutorial '#{@tutorial.name}' created!"
      redirect_to lessons_path @track
    else
      render 'new'
    end
  end

  def show
  	@tutorial = Tutorial.find_by_permalink(params[:permalink])
    @track = Track.find(@tutorial.track_id)
    @course = Course.find(@track.course_id)
    track_content = @track.lessons + @track.tutorials

    track_content.each do |c|
      if c != @tutorial
        if c.order == @tutorial.order + 1
        	if c.class.name != @tutorial.class.name
          	@next_item = Lesson.find(c.id)
          else
          	@next_item = Tutorial.find(c.id)
          end
        end
      end
    end

    if @tutorial.user_id
      @creator = User.find(@tutorial.user_id)
    else
      @creator = User.find_by_permalink('admin')
    end
  end

  def edit
    @tutorial = Tutorial.find_by_permalink(params[:permalink])
    @track = Track.find(@tutorial.track_id)
    @course = Course.find(@track.course_id)
  end

  def update
    @tutorial = Tutorial.find_by_permalink(params[:permalink])
    @track = Track.find(@tutorial.track_id)
    if @tutorial.update_attributes(tutorial_params)
      flash[:success] = "Tutorial updated successfully"
      redirect_to tutorial_path @tutorial
    else
      render 'edit'
    end
  end

  def destroy
    lesson = Lesson.find_by_permalink(params[:permalink])
    track = Track.find(lesson.track_id)
    lesson.destroy
    flash[:success] = "Lesson successfully deleted."
    redirect_to lessons_path track
  end

  def index
    @track = Track.find_by_permalink(params[:permalink])
    @items = @track.items
    @lessons = @track.lessons.all.sort_by! { |l| l.order }
    @course = Course.find(@track.course_id)
  end

  private

    def authorized_user
      if current_user.admin? || current_user.course_creator?
      else
       redirect_to courses_url, notice: "You do not have the correct privileges to access this page"
      end
    end

    def tutorial_params
      params.require(:tutorial).permit(:name, :content, :order, :track_id)
    end
end
