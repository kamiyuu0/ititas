class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 80 }
  validates :target_date, presence: true
  validates :target_date, uniqueness: { scope: :user_id, message: "はすでに登録されています" }
end
