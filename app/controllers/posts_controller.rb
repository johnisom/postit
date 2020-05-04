class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update vote]
  before_action :require_user, only: %i[new create edit update vote]

  def index
    @posts = Post.all.sort_by(&:total_votes).reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = 'Post successfully created'
      redirect_to posts_path
    else
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
      render :edit
    end
  end

  def vote
    vote = Vote.create(
      voteable: @post,
      creator: current_user,
      vote: params[:vote]
    )

    if vote.errors.none?
      flash[:notice] = 'Your vote was counted.'
    else
      flash[:danger] = 'You can only vote once.'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
