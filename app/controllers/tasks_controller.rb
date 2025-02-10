class TasksController < ApplicationController
  before_action :set_category
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /categories/:category_id/tasks
  def index
    @tasks_today = Task.where(due_date: Date.today.all_day).where(category: @category).order(priority: :desc)
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

    if @task.save
      redirect_to category_path(@category), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # GET /categories/:category_id/tasks/:id/edit
  def edit
  end

  # PATCH/PUT /categories/:category_id/tasks/:id
  def update
    if @task.update(task_params)
      redirect_to category_task_path(@category, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/:category_id/tasks/:id
  def destroy
    @task.destroy
    redirect_to category_path(@category), notice: 'Task was successfully deleted.'
  end

  private
    def set_category
      @category = Category.find(params[:category_id])  # Find the category for nested resources
    end

    def set_task
      @task = @category.tasks.find(params[:id])  # Find the task within the specific category
    end

    def task_params
      params.require(:task).permit(:name, :description, :due_date, :priority, :completed)
    end
end
