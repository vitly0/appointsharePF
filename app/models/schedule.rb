class Schedule < ApplicationRecord
  belongs_to :end_user
  has_many :schedule_comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :attends, dependent: :destroy
  
  has_one_attached :schedule_image
  
  def get_schedule_image
    (schedule_image.attached?) ? schedule_image : 'default_image.jpg'
  end
  
  def full_day
    year.to_s + "年" + month.to_s + "月" + day.to_s + "日"
  end
  
  def attended?(end_user)
    attends.where(end_user_id: end_user.id).exists?
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Schedule.where(title: content)
    elsif method == 'forward'
      Schedule.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Schedule.where('title LIKE ?', '%'+content)
    else
      Schedule.where('title LIKE ?', '%'+content+'%')
    end
  end
  
end
