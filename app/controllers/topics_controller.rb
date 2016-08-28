class TopicsController < ApplicationController
	before_action :authenticate_user!, :except=>[:index,:show]
    before_action :check_author?,:only=>[:edit,:update,:destroy]
	def index
		@topics=Topic.page(params[:page]).per(5)
	end

	def show
		@topic=Topic.find(params[:id])
		@user=@topic.user
	end

	def new
		@topic=Topic.new
	end

	def create
		@topic=Topic.new(params.require(:topic).permit(:title,:content))
	    @topic.user=current_user
	    @user=@topic.user
	    if @topic.save
	    	flash[:notice]="新增成功"
	    	redirect_to topic_path(@topic)
	    else
	    	render :action=>:new
	    end
	end

	def edit
	end

	def update
		if @topic.update(params.require(:topic).permit(:title,:content))
		  flash[:notice]="更新成功"
		  redirect_to topic_path(@topic)
		else
		  render :action=>:edit
		end
	end

	def destroy
		@topic.delete
		redirect_to topics_path
	end

	private
	def check_author?
        @topic = current_user.topics.find_by_id(params[:id])
	    unless @topic
	    	flash[:notice]="作者才能執行"
        	redirect_to topics_path
        	return
        end
	end

end
