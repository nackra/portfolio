class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment.save
  end

  def edit
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.update(post_comment_params)
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find_by(id: params[:id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
