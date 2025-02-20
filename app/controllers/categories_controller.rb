class CategoriesController < ApplicationController
  before_action :require_login
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = current_user.categories.includes(tasks: :category).order(created_at: :desc)
    @tasks_today = current_user.tasks.where(due_date: Date.today.all_day).order(priority: :desc)
    @category = Category.new 
  end

  # GET /categories/1 or /categories/1.json
  def show
    @tasks = @category.tasks
  end

  # GET /categories/new
  def new
    @category = current_user.Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = current_user.categories.build(category_params)
    
    if @category.save
      redirect_to @category, notice: "Category was successfully created."
    else
      # Prepare variables needed by the index view
      @categories = Category.includes(tasks: :category).order(created_at: :desc)
      @tasks_today = Task.where(due_date: Date.today.all_day).order(priority: :desc)
      render :index, status: :unprocessable_entity
    end
  end
  

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_path, status: :see_other, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.expect(category: [ :name ])
    end
end
