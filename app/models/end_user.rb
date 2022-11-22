class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :schedules, dependent: :destroy
  has_many :schedule_comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :attends, dependent: :destroy
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :department_name, presence: true
  validates :work_location, presence: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
  
  has_one_attached :profile_image
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def full_name
    first_name + " " + last_name
  end

  def full_name_kana
    first_name_kana + " " + last_name_kana
  end
  
  def follow(end_user_id)
    relationships.create(followed_id: end_user_id)
  end
  # フォローを外すときの処理
  def unfollow(end_user_id)
    relationships.find_by(followed_id: end_user_id).destroy
  end
  # フォローしているか判定
  def following?(end_user)
    followings.include?(end_user)
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      EndUser.where(first_name: content)
    elsif method == 'forward'
      EndUser.where('first_name LIKE ?', content + '%')
    elsif method == 'backward'
      EndUser.where('first_name LIKE ?', '%' + content)
    else
      EndUser.where('first_name LIKE ?', '%' + content + '%')
    end
  end
  
  def self.guest
    find_or_create_by!(first_name: 'guest', last_name: 'user', first_name_kana: 'ゲスト', last_name_kana: 'ユーザー'  , email: 'guest@example.com', department_name: '情報システム部', work_location: '本部支店', telephone_number: '00011112222') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.first_name = "guest"
      end_user.last_name = "user"
      end_user.first_name_kana = "ゲスト"
      end_user.last_name_kana = "ユーザー"
      end_user.email = "guest@example.com"
      end_user.department_name = "情報システム部"
      end_user.work_location = "本部支店"
      end_user.telephone_number = "00011112222"
    end
  end
end