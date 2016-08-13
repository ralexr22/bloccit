class API::V1::PostsController < Api::V1::TopicsController

  def create
    topic = Topic.find(params[:topic_id])
    post = Post.new(post_params)
    post.topic = topic

    if post.valid?
      post.save!
      render json: post, status: 201
    else
      render json: {error: "Post is invalid", status: 400}, status: 400
    end
  end
end
