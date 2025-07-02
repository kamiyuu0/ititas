class TasksController < ApplicationController
  def index
    @tasks = Task.all.includes(:user).where(is_public: true, target_date: Date.today).order(target_date: :asc)
  end

  def new
    if current_user.tasks.where(target_date: Date.today).exists?
      redirect_to tasks_path, alert: "今日のタスクはすでに登録されています。"
      return
    end
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.target_date = Date.today

    if @task.save
      redirect_to task_path(@task), notice: "Task was successfully created."
    else
      # TODO: エラーメッセージを表示するための処理を追加
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :description, :target_date, :done, :is_public)
  end
end
