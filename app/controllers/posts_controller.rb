class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :destroy, :update, :show]
  before_action :authenticate_user!, except: [:show]
  def index 
    @posts = Post.where(user: current_user)
  end

  def new  
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save 
      redirect_to posts_path, notice: 'post was successfully created!'
    else
      render :new
    end
  end

  def edit; end

  def update 
    if @post.update(post_params)
      redirect_to posts_path, notice: 'post was successfully updated!'
    else
      render :edit 
    end
  end

  def show;  end

  def destroy 
    @post.destroy
    redirect_to posts_path, notice: 'post was successfully detroyed!'
  end
  private 

  def post_params 
    params.require(:post).permit(:title, :description, :user_id)
  end
  
  def set_post 
    @post = Post.find(params[:id])
  end
end
