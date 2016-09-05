class CommentsController < ApplicationController

	def create
		@topic = Topic.find(params[:topic_id])
		@comment=@topic.comments.build(comment_params)
	    @comment.user=current_user
	    @comment.save
		redirect_to topic_path(@topic)
	end

	protected
	def comment_params
		params.require(:comment).permit(:content)
	end
end
