class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 # モデル関連づけ
  has_many :books, dependent: :destroy
  # gem refile
  attachment :profile_image, destroy: false
  # bookcomment 1:n
  has_many :book_comments, dependent: :destroy
  # favorite
  has_many :favorites, dependent: :destroy

# フォロー機能　フォロワー機能
  # 自分がフォローしているユーザとの関連
  # 重複しないように仮の名前を与える
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して[Follower]モデルのUser[フォローされた人]を取得する
  has_many :followings, through: :active_relationships, source: :follower
  #

  # 自分がフォローされているユーザとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  #


  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: { maximum: 20, minimum: 2}
  # validation introduction
  validates :introduction, length: { maximum: 50 }

# フォロー機能　relationships の中にuser_id[follower_id]が尊愛しているか
  def followed_by?(user)
      passive_relationships.find_by(following_id: user.id).present?
  end
#

end
