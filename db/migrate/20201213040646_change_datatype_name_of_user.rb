class ChangeDatatypeNameOfUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :user_id, false
  end
end
