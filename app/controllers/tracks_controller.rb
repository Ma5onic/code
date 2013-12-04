class TracksController < ApplicationController
  before_action :admin_user, only: [:new, :create, :destroy]
  
  def new
  	@track = Track.new
  end

  def create
    @course = Course.find_by_permalink(params[:permalink])
    @track = @course.tracks.create(track_params)
    if @track.save
      flash[:success] = "Track created!"
      redirect_to courses_url
    else
      render 'new'
    end
  end

  def show
  	@track = Track.find_by_permalink(params[:permalink])
    @course = Course.find(@track.course_id)
  end

  def edit
    @track = Track.find_by_permalink(params[:permalink])
    @course = Course.find(@track.course_id)
  end

  def update
    @track = Track.find_by_permalink(params[:permalink])
    @course = Course.find(@track.course_id)
    if @track.update_attributes(track_params)
      flash[:success] = "Track updated successfully"
      redirect_to tracks_path @course
    else
      render 'edit'
    end
  end

  def destroy
    Track.find_by_permalink(params[:permalink]).destroy
    flash[:success] = "Track successfully deleted."
    redirect_to courses_url
  end

  def index
  	@course = Course.find_by_permalink(params[:permalink])
  	@tracks = @course.tracks.all.sort_by! { |c| c.name.downcase }
  end

  private

  	def admin_user
			redirect_to courses_url, notice: "You do not have the correct privileges to access this page" unless current_user.admin?
		end

    def track_params
      params.require(:track).permit(:name, :description, :permalink)
    end
end
