class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def index
    follow_type = params[:type]
    @user = User.find params[:id]
    @users = @user.send(follow_type).paginate page: params[:page], per_page: Settings.per_page
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow! @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow! @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
