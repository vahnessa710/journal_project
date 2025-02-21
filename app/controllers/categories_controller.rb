class CategoriesController < ApplicationController
  before_action :require_login
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories
  def index
    @categories = current_user.categories.includes(tasks: :category).order(created_at: :desc)
    @tasks_today = current_user.tasks.where(due_date: Date.today.all_day).order(priority: :desc)
    @category = Category.new 
  end

  # GET /categories/1 
  def show
    @tasks = @category.tasks
  end

  # GET /categories/new
  def new
    @category = current_user.categories.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = current_user.categories.build(category_params)
    
    if @category.save
      redirect_to @category
    else
      # Prepare variables needed by the index view
      @categories = current_user.categories.includes(tasks: :category).order(created_at: :desc)
      @tasks_today = current_user.tasks.where(due_date: Date.today.all_day).order(priority: :desc)

      render :index, status: :unprocessable_entity
    end
  end
  

  # PATCH/PUT /categories/1 
  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1 
  def destroy
    @category.destroy!
    redirect_to categories_path, status: :see_other
  end
  

  private
    
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
    
end
