class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first # TODO: make this actual LOL

    if @post.save
      flash[:notice] = 'Post successfully updated'
      redirect_to posts_path
    else
      flash[:error] = 'Post could not be updated'
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post successfully updated'
      redirect_to @post
    else
      flash[:error] = 'Post could not be updated'
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
