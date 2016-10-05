class PostsController < ApplicationController
  before_filter :set_post, except: [:index, :new, :create]
  before_filter :require_auth, only: [:new, :create, :edit, :update]
  before_filter :allow_framing, only: [:show]

  def index
    query = %w(% %).join params[:q].to_s.gsub('%', '\\%').gsub('_', '\\_')
    @posts = Post.where("name LIKE ? OR body LIKE ?", query, query).order(params[:order])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create post_params
    if @post.new_record?
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render :new
    else
      redirect_to post_path(@post)
    end
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      redirect_to edit_post_path(@post)
    end
  end

  def vote
    session["votes"] ||= []
    if session["votes"].include? params[:id]
      return render json: { error: "Already voted", votes: @post.votes }
    end

    session["votes"] << params[:id]
    render json: @post.vote(params[:type])
  end

  private
  def set_post
    @post = Post.find_by_id params[:id]
  end

  def post_params
    params.require(:post).permit(:name, :body)
  end

end
