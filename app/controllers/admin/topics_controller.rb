class Admin::TopicsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin
    layout "admin"

    def index
    	
    end

    protected

    def authenticate_admin
      unless current_user.admin?
        flash[:notice]="you are not allowed"
        redirect_to topics_path
      end

    end

end
