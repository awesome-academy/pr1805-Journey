class RelationsController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    @unfollow = current_user.active_relations.find_by(followed_id: @user.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relation.find_by(id: params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
