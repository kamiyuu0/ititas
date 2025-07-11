class TasksController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def index
    @tasks = Task.all.includes(:user).where(is_public: true, target_date: Time.zone.today).order(target_date: :asc)
    @yesterday_steps = Task.where(target_date: Time.zone.yesterday).count
  end

  def new
    if current_user.tasks.where(target_date: Time.zone.today).exists?
      redirect_to request.referer, alert: "今日のタスクはすでに登録されています。"
      return
    end
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.target_date = Time.zone.today

    if @task.save
      redirect_to mypage_path, notice: "今日のタスクを登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
    if !@task.is_public && !current_user.presence&.own?(@task)
      redirect_to tasks_path, alert: "このタスクは非公開です。"
      return
    end

    @url = if @task.done
      "https://res.cloudinary.com/desktest/image/upload/l_done_stamp_ihruve,w_800,h_450/l_text:Sawarabi%20Gothic_50_bold:#{@task.title},co_rgb:333,w_500,c_fit/v1751531494/ititas_dynamic_ogp_fqonfa.png"
    else
      "https://res.cloudinary.com/desktest/image/upload/l_text:Sawarabi%20Gothic_50_bold:#{@task.title},co_rgb:333,w_700,c_fit/v1751531494/ititas_dynamic_ogp_fqonfa.png"
    end
    set_meta_tags(og: { image: @url }, twitter: { image: @url })
  end

  def complete
    @task = current_user.tasks.find(params[:id])
    if @task.target_date == Time.zone.today
      @task.update(done: true)
      redirect_to mypage_path, notice: "今日のタスクを完了しました！！！"
    else
      # ここには来れないはずだが、念のための処理
      redirect_to mypage_path, alert: "今日以外のタスクは完了にできません。"
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :target_date, :done, :is_public, :mood)
  end
end
