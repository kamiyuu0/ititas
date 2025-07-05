class ChangeColumnToNull < ActiveRecord::Migration[7.2]
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :tasks, :description, true
  end

  def down
    change_column_null :tasks, :description, false
  end
end
