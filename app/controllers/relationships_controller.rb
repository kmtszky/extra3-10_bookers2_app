class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = 'successfully followed !'
      redirect_back(fallback_location: books_path)
    else
      flash[:error_explanation] = 'can not follow...! please re-try'
      redirect_back(fallback_location: books_path)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = 'successfully unfollow'
      redirect_back(fallback_location: books_path)
    else
      flash[:error_explanation] = 'can not unfollow...! please re-try'
      redirect_back(fallback_location: books_path)
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end