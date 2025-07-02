class UsersController < ApplicationController
  def show
    @user = current_user
    @tasks = @user.tasks.order(target_date: :desc)
  end
end
