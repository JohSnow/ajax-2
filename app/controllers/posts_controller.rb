class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id DESC").all   # 新帖在前面
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

  end

  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user) # 如果已经点过赞 就略过不新增
      Like.create( :user => current_user, :post => @post)
    end

  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    render "like"
  end

  def join
    @post = Post.find(params[:id])
    if !current_user.is_member_of?(@post)
      current_user.join!(@post)
    end
    redirect_to posts_path
  end

  def quit
    @post = Post.find(params[:id])
    if current_user.is_member_of?(@post)
      current_user.quit!(@post)
    end
    redirect_to posts_path
  end


    protected

    def post_params
      params.require(:post).permit(:content)
    end
end
