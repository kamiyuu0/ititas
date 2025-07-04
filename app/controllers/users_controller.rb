class UsersController < ApplicationController
  def show
    @user = current_user
    @tasks = @user.tasks.order(target_date: :desc)
    @today_task = current_user.tasks.find_by(target_date: Time.zone.today)
  end
end
