class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def index
    @book = Book.new #空のカラムを作成
    @user = current_user
    @users = User.all #データ（レコード）を全件取得
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    @books = @user.books #アソシエーションを持っているモデル同士の記述 #ユーザーが投稿したBookのデータを取れるようにした
    @book = Book.new #空のカラムを作成
    #@book_find = Book.find(params[:id]) # データ（レコード）を1件取得
  end

  def edit
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    # if @user == current_user # データ（レコード）を更新 #条件文（条件式が可の場合は〇〇の処理を、偽の場合は✖✖の処理をする️
    #   render :edit #アクションを通さないパス #条件式が偽の場合は✖✖️️の処理をする
    # else
    #   redirect_to user_path(current_user)
    # end
  end

  def update
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    if @user.update(user_params) # データ（レコード）を更新 #条件文（条件式が可の場合は〇〇の処理を、偽の場合は✖✖の処理をする️
      flash[:notice] = "You have updated user successfully." #Userのプロフィール更新が成功したときのフラッシュメッセージ
      redirect_to user_path(current_user) # 詳細一覧画面へリダイレクト #条件式が可の場合は〇〇の処理をする
    else
      render :edit #アクションを通さないパス #条件式が偽の場合は✖✖️️の処理をする
    end
  end

  private #privateは記述をしたコントローラ内でしか参照できない（※protectedは呼び出された他のコントローラからも参照することができる）

  def user_params
    params.require(:user).permit(:name, :profile_image ,:introduction) #ストロングパラメーター
  end

  def correct_user
    @user = User.find(params[:id])  # データ（レコード）を1件取得
    # @user = user.books # 投稿者のデータから投稿者の全ての本のデータの取得
    unless @user == current_user
     redirect_to user_path(current_user)
    end
  end

end