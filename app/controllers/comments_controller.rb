class CommentsController < ApplicationController
  before_action :set_post
    def create 
      @comment = @post.comments.new(comment_params)
      set_user()
      @comment.save
      redirect_to post_path(@post)
    end

    private 

    def comment_params
      params.require(:comment).permit(:description, :post_id )
    end

    def set_post 
      @post = Post.find(params[:post_id])
    end

    def set_user() 
      if current_user
        @comment.user = current_user
      else 
        user = User.find_by_email('anonymous@mail.com')
        user = User.create(email: 'anonymous@mail.com', password:'123456') if user.nil?
        @comment.user = user    
      end
    end
end
