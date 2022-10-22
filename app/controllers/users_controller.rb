class UsersController < ApplicationController
  def index
    @book = Book.new #空のカラムを作成
    @users = User.all #データ（レコード）を全件取得
  end

  def show
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    # @books = @user.books #アソシエーションを持っているモデル同士の記述
    @book_new = Book.new #空のカラムを作成
    @book = Book.find(params[:id]) # データ（レコード）を1件取得
  end

  def edit
    @user = User.find(params[:id])  # データ（レコード）を1件取得
  end

  def update
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    @user.update(user_params) # データ（レコード）を更新
    redirect_to user_path # 詳細一覧画面へリダイレクト
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end