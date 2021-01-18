class Admins::CommentsController < ApplicationController
  
  
  
  def destroy
    if @comment = Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to admins_post_path(params[:post_id])
    else
      flash[:notice] = "コメントの削除に失敗しました。"
      redirect_to adminpost_path(@post.id)
    end
  end
  
  
end
