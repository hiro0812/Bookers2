class UsersController < ApplicationController
  def index
    @book = Book.new #空のカラムを作成
    @users = User.all #データ（レコード）を全件取得
  end

  def show
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    # @books = @user.books #アソシエーションを持っているモデル同士の記述
    @book = Book.new #空のカラムを作成
    # @book = Book.find(params[:id]) # データ（レコード）を1件取得
  end

  def edit
    @user = User.find(params[:id])  # データ（レコード）を1件取得
  end

  def update
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    if @user.update(user_params) # データ（レコード）を更新 #条件文（条件式が可の場合は〇〇の処理を、偽の場合は✖✖の処理をする️
      redirect_to user_path # 詳細一覧画面へリダイレクト #条件式が可の場合は〇〇の処理をする
    else
      render :edit #アクションを通さないパス #条件式が偽の場合は✖✖️️のを理
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image) #
  end

  def correct_user
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @user = @book.user #
    redirect_to(books_path) unless @user == current_user #
  end

end