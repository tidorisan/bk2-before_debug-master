class Relationship < ApplicationRecord
# 関連付けだが同一のUserでは表記が上書きされてしまうので、仮に別の名前を与えて指定する
	# 関連付け_子モデル_フォロー機能 user[following]
	belongs_to :following, class_name: "User"
	# 関連付け_子モデル_フォロー機能 user[follower]
	belongs_to :follower, class_name: "User"
# ＝＝＠＝＝確認する
# ==@== 制限した
	# バリデーションチェック　フォロー機能　AユーザがBユーザフォロする　following_id:A, follower_id:bができるのは一回のみ
	# validates_uniqueness_of :followe_id, scope: :user_id
	validates :follower_id, uniqueness: { scope: :follower_id }
	#

end
