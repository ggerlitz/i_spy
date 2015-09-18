class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by(username: params[:username])
			if @user and @user.password == params[:password]
				session[:user_id] = @user.id
				redirect_to '/', notice: "Successfully logged in!"
			else
				redirect_to login_path, notice: "Login info was incorrect"
			end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/', notice: "Logged out!"
	end
end