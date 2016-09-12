class Admin::CategorysController < AdminApplicationController


  def index
  	@categorys = Category.all
    if params[:id]
       @category = Category.find(params[:id])

    else
       @category = Category.new
    end
   
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    if @category.save
      flash[:notice] = "新增成功"
      redirect_to admin_categorys_path
    else
      @categorys = Category.all  # for render to index having @category
      render :action => :index
    end  
      
  end

  def update
    @category = Category.find(params[:id])
    
    if @category.update(params.require(:category).permit(:name))
      flash[:notice] = "更新成功"
    end  
      redirect_to admin_categorys_path
  end  

  def destroy
    @category = Category.find(params[:id])
    if @category.topics.count == 0
        @category.destroy
        flash[:notice] = "刪除成功"
    else
      flash[:notice] = "此分類已在使用無法刪除"
    end  
    redirect_to admin_categorys_path
  end




end
