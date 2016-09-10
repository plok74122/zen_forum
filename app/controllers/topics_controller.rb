class TopicsController < ApplicationController
	before_action :authenticate_user!, :except=>[:index,:show,:about]
    before_action :check_author,:only=>[:edit,:update,:destroy]
	def index
        @topics = Topic.all
        @topics.each do |topic|
        	topic.comments_number=topic.comments.count
        	topic.comments_lastest_time=topic.comments.last.try(:created_at)
        	topic.save
        end

      if params[:category]
		    @topics = Category.find_by_name(params[:category]).topics
		# elsif params[:category]=="technical"
		#     @topics = Category.find(2).topics
		# elsif params[:category]=="psychological"
		#     @topics = Category.find(3).topics
			else
		    @topics=Topic.all 
			end


        if params[:order]     
        # == 'comments_number'
        	sort_by = "#{params[:order]} Desc"
        # elsif params[:order] == 'comments_lastest_time'
        # 	sort_by ='comments_lastest_time Desc'
        # elsif params[:order] == 'visitingnumber'
        # 	sort_by ='visitingnumber Desc'
        else
        	sort_by ='created_at'
        end



		@topics = @topics.where(:status_published => :true).order(sort_by).page(params[:page]).per(5)

		# if current_user
		# 	@user=current_user
		# end

	end

	def show
			
		@topic=Topic.find(params[:id])
		if params[:record]=="viewing"
			@topic.visitingnumber=@topic.visitingnumber+1
			@topic.save
	   end
		# @user=@topic.user

		
		if params[:comment_id]
			@topic = Topic.find(params[:id])
			@comment=@topic.comments.find(params[:comment_id])
	  else
			@comment=Comment.new
	  end

    unless @comment.new_record? || @comment.is_author?(current_user)
    	flash[:alert] = "This is not your comment!"
    	redirect_to topic_path(@topic)
    	return
    end

	end

	def new
		@topic=Topic.new
	end

	def create
		@topic=Topic.new(params.require(:topic).permit(:title,:content,:status_published,:category_ids=>[]))
	    @topic.user=current_user
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
		if @topic.update(params.require(:topic).permit(:title,:content,:status_published))
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

	def about
		@users=User.all
		@topics=Topic.all
		@comments=Comment.all
	end

	def keep
		@topic=Topic.find(params[:id])
		if current_user.keepedTopic?(@topic)
			current_user.keeptopics.delete(@topic)
			# flash[:notice]="你已取消收藏"
		else
			current_user.keeptopics <<@topic
			# flash[:notice]="收藏成功"
		end

		respond_to do |format|
			format.js
		end

	end

	private
	def check_author
		if current_user.admin?
			@topic = Topic.find_by_id(params[:id])
		else	
	    @topic = current_user.topics.find_by_id(params[:id])

		    unless @topic 
		  	  flash[:notice]="作者才能執行"
		    	redirect_to topics_path
		    	return
		    end
	  end 
	end

end
