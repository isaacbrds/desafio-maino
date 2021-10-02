class WelcomeController < ApplicationController
  def index
    @posts = Post.order("created_at DESC").page(params[:page])
  end
end
