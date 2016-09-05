class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_author,:only=>[:update,:destroy]

	def create
		@topic = Topic.find(params[:topic_id])
		@comment=@topic.comments.build(comment_params)
	    @comment.user=current_user
	    
	    if @comment.save
	    	flash[:notice]="新增成功"
	    end
		redirect_to topic_path(@topic)

	    
	end

	def update
		@topic = Topic.find(params[:topic_id])
		if @topic.comments.find(params[:id]).update(comment_params)
		   flash[:notice]="更新成功"
	    end
		redirect_to topic_path(@topic)
	end

	def destroy
		# @topic = Topic.find(params[:topic_id])
		# @comment=@topic.comments.find(params[:id])
		if @comment.delete
			flash[:notice]="刪除成功"
		end
		redirect_to topic_path(@topic)
	end

	protected
	def comment_params
		params.require(:comment).permit(:content)
	end

	def check_author
		@topic = Topic.find(params[:topic_id])
		@comment=current_user.comments.find_by_id(params[:id])
		unless @comment
           flash[:notice]="you are not allowed"
           redirect_to topic_path(@topic)
		end

	end
end
