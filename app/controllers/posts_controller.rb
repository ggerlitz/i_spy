class PostsController < ApplicationController
 before_action :set_post, only: [:show, :edit, :update, :destroy]
 before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

 def index
  @posts = Post.all
 end

 def new
  @post = Post.new
 end

def edit
end

 def show
 	@user = current_user
  @posts = Post.all
  @comment = Comment.new
 end

 def create
     @post = Post.create(posts_params)
     redirect_to @post, notice: "New post created"
 end

 def update
 		@post.update(posts_params)
 		redirect_to @post, notice: "Post updated!"
 end

 def destroy
 		@post.destroy
 		redirect_to post_path, notice: "Post deleted!"
 end

 private

	def posts_params
		params.require(:post).permit(:body, :title).merge(user: current_user)
	end

  def set_post
      @post = Post.find(params[:id])
  end

end