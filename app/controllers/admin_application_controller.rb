class AdminApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :authenticate_admin
  layout "admin"

  protected

  def authenticate_admin
    unless current_user.admin?
      flash[:notice]="you are not allowed"
      redirect_to topics_path
    end

  end
end
