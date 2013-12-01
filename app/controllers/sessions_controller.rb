class SessionsController < ApplicationController
	before_action :already_signed_in_user, only: [:create, :new]

	def new
	end

	def create
		user = User.find_by(username: params[:session][:username].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or root_url
		else
			flash.now[:error] = 'Invalid Username/Password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
