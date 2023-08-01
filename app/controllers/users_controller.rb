class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def confirm
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root
  end

  def favorites
    @user = User.find(params[:user_id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @posts = @user.posts.page(params[:page]).reverse_order
  end
  # フォロー一覧
def follows
  user = User.find(params[:id])
  @users = user.following_users
end

# フォロワー一覧
def followers
  user = User.find(params[:id])
  @user = user.follower_users
end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
