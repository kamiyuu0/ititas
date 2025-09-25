class NotifyDispatcherJob < ApplicationJob
  queue_as :default

  def perform
    now = Time.current.in_time_zone("Asia/Tokyo").change(sec: 0)
    target_time = Time.parse("2000-01-01 #{now.strftime('%H:%M')}:00") #pgのtime型のデフォルト年月日は2000-01-01

    #TODO:リファクタリング
    tmp_user = User.where(provider: "line", notification_enabled: true)
    tmp2_user = tmp_user.where("notification_time = ?", target_time)
    
    # logger
    Rails.logger "#{tmp2_user.first.name}::::#{tmp2_user.first.notification_time}:::::#{target_time}"

    tmp2_user.find_each do |user|
      puts user.name
      NotifyLineJob.perform_later(user.id)
    end
  end
end
