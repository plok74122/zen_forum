class UsersController < ApplicationController
	before_action :authenticate_user!,:except=>[:show]
	before_action :check_author,:except=>[:show]
	def show
		@user=User.find(params[:id])
		
	end

	def edit	
		@user=User.find(params[:id])
	end

	def update
    @user=User.find(params[:id])
		@user.update(params.require(:user).permit(:profile, :name))
		redirect_to user_path(@user)
	end

	def check_author
		 @user=User.find(params[:id])
		 unless @user==current_user
        flash[:notice]="you are not allowed"
        redirect_to user_path(@user)
        return
		 end
	end
end
