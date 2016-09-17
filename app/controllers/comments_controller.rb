class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_author, :only => [:update, :destroy]

  def create
    @topic = Topic.find(params[:topic_id])
    @comment=@topic.comments.build(comment_params)
    @comment.user=current_user

    if @comment.save
      flash[:notice]="新增成功"
      # @topic.comments_number += 1
      # 	@topic.comments_lastest_time = @comment.created_at
      # 	@topic.save
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "留言不能是空白"
    end
    redirect_to topic_path(@topic)


  end

  def update
    @topic = Topic.find(params[:topic_id])
    # @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice]="更新成功"
      redirect_to topic_path(@topic)
    else
      render 'topics/show.html.erb'
    end
  end

  def destroy
    # @topic = Topic.find(params[:topic_id])
    # @comment=@topic.comments.find(params[:id])

    @comment.destroy
    # flash[:notice]="刪除成功"
    # @topic.comments_number -= 1

    #    @topic.save

    # if @topic.comments.count==0
    # 	@topic.comments_lastest_time =" "
    # 	@topic.save
    #    else
    #      @topic.comments_lastest_time = @topic.comments.last.created_at
    #    end


    # redirect_to topic_path(@topic)
    respond_to do |format|
      format.js
    end

  end

  protected
  def comment_params
    params.require(:comment).permit(:content, :status_published)
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
