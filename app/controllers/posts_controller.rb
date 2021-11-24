class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :destroy, :update, :show]
  before_action :authenticate_user!, except: [:show]
  def index 
    @posts = Post.where(user: current_user)
    
    tag_titles = params[:tags]
    
    if tag_titles.present?
      @posts = @posts.joins(:tags).where(tags: { title: tag_titles }).distinct 
    end
  end

  def new  
    @post = Post.new
    @tags = @post.tags.build
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save 
      redirect_to posts_path, notice: t('post was successfully created!')
    else
      render :new
    end
  end

  def edit 
    redirect_to posts_path, alert: t("you don't have permission to edit this") unless @post.user == current_user
  end

  def update 
    if @post.update(post_params)
      redirect_to posts_path, notice: t('post was successfully updated!')
    else
      render :edit 
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order("created_at DESC")
  end

  def destroy 
    @post.destroy
    redirect_to posts_path, notice: t('post was successfully detroyed!')
  end

  def import
    
    arquivo = Post.import params[:arquivo]
    @response = ImportPostJob.perform_later arquivo
    if @response
      redirect_to posts_path, notice: t('post was successfully imported!')
    else
      render :index, notice: t('post was not successfully imported!')
    end
  end
  private 


  
  def post_params 
    params.require(:post).permit(:title, :description, :thumbnail,tags_attributes: [:id, :title])
  end

  
  def set_post 
    @post = Post.find(params[:id])
  end
end
