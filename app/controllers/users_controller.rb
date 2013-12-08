class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :destroy, :dashboard, :courses]
	before_action :correct_user,	 only: [:edit, :update]
	before_action :admin_user,     only: :destroy
	before_action :already_signed_in_user, only: [:create, :new]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Code!"
			redirect_to custom_user_path @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find_by_permalink(params[:permalink])
		@lessons = @user.lessons.all.sort_by! { |l| l.track_id <=> l.order }
	end

	def edit
  end

  def editpassword
  	@user = User.find_by_permalink(params[:permalink])
  end

  def updatepassword
  	if @user.update_attributes(password_user_params)
  		flash[:success] = "Password updated"
  		redirect_to custom_user_path @user
  	else
  		render :editpassword
  	end	
  end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to custom_user_path @user
		else
			render :edit
		end
	end

	def destroy
		User.find_by_username(params[:permalink]).destroy
		flash[:success] = "User deleted."
		redirect_to root_url
	end

	def dashboard
	end

	def courses
		@languages = Language.all
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :username, :location,
																	 :password, :password_confirmation)
		end

		def password_user_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		# Before filters

		def correct_user
			@user = User.find_by_permalink(params[:permalink])
			redirect_to(root_url) unless current_user?(@user)
		end

		def admin_user
			redirect_to root_url unless current_user.admin?
		end
end
