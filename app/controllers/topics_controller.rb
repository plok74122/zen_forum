class TopicsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show, :about]
  before_action :check_author, :only => [:edit, :update, :destroy]

  def index
    @topics = Topic.all
    @topics.each do |topic|
      topic.comments_number=topic.comments.where(:status_published => :true).count
      topic.comments_lastest_time=topic.comments.where(:status_published => :true).last.try(:created_at)
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
      @topic.visitingnumber=@topic.visitingnumber + 1
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

    @like_num = Likeship.where(:topic => @topic).count

  end

  def new
    @topic=Topic.new
  end

  def create
    @topic=Topic.new(topic_params)
    @topic.user=current_user
    if @topic.save
      flash[:notice]="新增成功"
      redirect_to topic_path(@topic)
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if params[:remove_upload_file]=='1'
      @topic.photo=nil
    end

    if @topic.update(params.require(:topic).permit(:title, :content, :photo, :status_published))
      flash[:notice]="更新成功"
      redirect_to topic_path(@topic)
    else
      render :action => :edit
    end
  end

  def destroy
    @topic.destroy
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
      current_user.keeptopics.destroy(@topic)
      # flash[:notice]="你已取消收藏"
    else
      current_user.keeptopics <<@topic
      # flash[:notice]="收藏成功"
    end

    respond_to do |format|
      format.js
    end

  end

  def like
    @topic=Topic.find(params[:id])
    if current_user.likedTopic?(@topic)
      current_user.like_topics.destroy(@topic)
      # flash[:notice]="你已取消收藏"
    else
      current_user.like_topics <<@topic
      # flash[:notice]="收藏成功"
    end

    @like_num = Likeship.where(:topic => @topic).count
    respond_to do |format|
      format.js
    end

  end

  def subscribe
    @topic=Topic.find(params[:id])
    if current_user.subscribedTopic?(@topic)
      current_user.subscribe_topics.destroy(@topic)
    else
      current_user.subscribe_topics <<@topic
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
  def topic_params
    params.require(:topic).permit(:title, :content, :status_published, :photo, :category_ids => [] , :tag_list => [])
  end

end
