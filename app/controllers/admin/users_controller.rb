class Admin::UsersController < AdminApplicationController
  

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(params.require(:user).permit(:profile, :name, :role))
      flash[:notice] = "更新成功"
      redirect_to admin_users_path
    else
    	render :action => :edit
    end

	end



end
