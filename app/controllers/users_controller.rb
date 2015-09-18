class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update, :follow, :unfollow]
  before_action :authenticate_user!, only: [:profile, :destroy, :edit, :update, :follow, :unfollow]
  before_action :authorize_user, only: [:destroy, :edit, :update]

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def show
    @posts = Post.all
    @comment = Comment.all
  end

  def edit
  end

  def profile
    @user = current_user
    render :show
  end  

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to posts_path, notice: "New account created!"
  end

  def update
    @user.update(user_params)
    redirect_to @user, notice: "Account updated!"
  end

  def destroy
  	@user.destroy
  	session[:user_id]= nil
  	redirect_to root_path, notice: "Account Deleted"
  end

  private

  def authorize_user
     unless @user == current_user
       redirect_to root_path, notice: "You do not have permission to do that."
     end 
   end

  def user_params
  	params.require(:user).permit(:username, :email, :password, :fname, :lname)
  end

  def set_user
  	begin
  			if params[:username]
  				username = params[:username]
  				@user = User.where("lower(username) = ?", username.downcase).first
  				unless @user
  					flash[:notice] = "That user could not be found."
  					redirect_to users_path
  				end
  			else 
  				@user = User.find(params[:id])
  			end
		rescue
			flash[:notice] = "That user could not be found."
			redirect_to users_path
		end
	end

end
