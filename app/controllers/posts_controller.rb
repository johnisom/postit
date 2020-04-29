class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

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
end
