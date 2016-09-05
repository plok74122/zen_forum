class UsersController < ApplicationController
	before_action :authenticate_user!
	def index
		@user=current_user
	end

	def edit	
		@user=current_user
	end
	def update
        @user=current_user
		@user.update(params.require(:user).permit(:profile))
		redirect_to users_path
	end
end
