class Users::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "コメントの投稿に失敗しました。"
      redirect_to post_path(@post.id)
    end
  end


  def destroy
    if @comment = Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to post_path(params[:post_id])
    else
      flash[:notice] = "コメントの削除に失敗しました。"
      redirect_to post_path(@post.id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :parent_id)
  end



end
