class TasksController < ApplicationController

  before_action :set_category, except: [:due_today] 
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  

  # GET /tasks/due_today
  def due_today 
    @tasks_due_today = Task.where(due_date: Date.today.all_day).order(priority: :desc)
  end


  # GET /categories/:category_id/tasks/:id
  def show
  end

  # GET /categories/:category_id/tasks/new
  def new
    @task = @category.tasks.build
  end

  # POST /categories/:category_id/tasks
  def create
    @task = @category.tasks.build(task_params)
    @task.category.user = current_user 
    if @task.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /categories/:category_id/tasks/:id/edit
  def edit
  end

  # PATCH/PUT /categories/:category_id/tasks/:id
  def update
    if @task.update(task_params)
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  # DELETE /categories/:category_id/tasks/:id
  def destroy
    @task.destroy
    redirect_to category_path(@category)
  end

  private
    def set_category
      @category = Category.find(params[:category_id])  # finds the category associated with the task
    end

    def set_task
      @task = @category.tasks.find(params[:id])  # find the task within the specific category; ensure the task belongs to the right category
    end

    def task_params
      params.require(:task).permit(:name, :description, :due_date, :priority)
    end

end
