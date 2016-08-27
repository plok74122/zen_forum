class TopicsController < ApplicationController
before_action :authenticate_user!, :except=>[:index,:show]

def index
	@topics=Topic.page(params[:page]).per(5)
end
end
