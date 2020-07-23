class RelationshipsController < ApplicationController

	def create
  		follow = current_user.active_relationships.build(follower_id: params[:user_id])
		# 条件
		if follow.save!
  			redirect_to request.referer
  		else
  			redirect_to request.referer
		end

  	end

	def destroy
  		# ここ記述まだ明確に和kってない
  		follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
		# 条件relationships テーブルに上記で指定したカラムと値が存在している場合はdesrtoy しない場合は何もせずに元のページへ
		follow.destroy!
		redirect_to request.referer
		#===========
	end


end
