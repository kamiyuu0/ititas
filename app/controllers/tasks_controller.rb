class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @tasks = Task.all.includes(:user).where(is_public: true, target_date: Date.today).order(target_date: :asc)
  end

  def new
    if current_user.tasks.where(target_date: Date.today).exists?
      redirect_to request.referer, alert: "今日のタスクはすでに登録されています。"
      return
    end
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.target_date = Date.today

    if @task.save
      redirect_to task_path(@task), notice: "今日のタスクを登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
    @url = "https://res.cloudinary.com/desktest/image/upload/l_text:Sawarabi%20Gothic_50_bold:#{@task.title},co_rgb:333,w_500,c_fit/v1751530379/ititas_dynamic_ogp_vwp3bq.png"
    set_meta_tags(og: { image: @url }, twitter: { image: @url })
  end

  def complete
    @task = current_user.tasks.find(params[:id])
    if @task.target_date == Date.today
      @task.update(done: true)
      redirect_to mypage_path, notice: "今日のタスクを完了しました！！！"
    else
      # ここには来れないはずだが、念のための処理
      redirect_to task_path(@task), alert: "今日以外のタスクは完了にできません。"
    end
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :description, :target_date, :done, :is_public)
  end
end
