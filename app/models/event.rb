class Event < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  validate :start_end_check

  def start_end_check
    # 開始時間が終了時間より前の時間を選択された場合のバリデーションエラーメッセージを追加
    if start_date > end_date
      errors.add( :end_date, "は開始時間より後の時間を入力してください。")
    end
  end

end
