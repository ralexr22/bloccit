class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]


  def create
    if params[:post_id]
      @resource = Post.find(params[:post_id])
    else
      @resource = Topic.find(params[:topic_id])
    end

    comment = @resource.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
    if params[:topic_id]
      redirect_to [@resource, @topic]
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@resource, @post]
    end
  end
end

  def destroy
    if params[:post_id]
      @resource = Post.find(params[:post_id])
    else
      @resource = Topic.find(params[:topic_id])
    end

   comment = @resource.comments.find(params[:id])

   if comment.destroy
     flash[:notice] = "Comment was deleted successfully."
    if params[:topic_id]
     redirect_to [@resource, @topic]
   else
     flash[:alert] = "Comment couldn't be deleted. Try again."
     redirect_to [@resource.topic, @post]
   end
  end
 end


private

  def comment_params
     params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
