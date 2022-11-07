class BooksController < ApplicationController
  def new
  end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @user = current_user
    @book.user_id = current_user.id #current_userは、現在ログイン中のユーザーに関する情報を取得できる
    if @book.save # データ（レコード）を保存 #条件文（条件式が可の場合は〇〇の処理を、偽の場合は✖✖の処理をする️）
      flash[:notice] = "You have created book successfully." #Bookの保存が成功したときのフラッシュメッセージ
      redirect_to book_path(@book.id) #条件式が可の場合は〇〇の処理をする。
    else
      @books = Book.all # データ（レコード）を全件取得 #renderパスはアクションを通らないパスのため再定義する必要がある。
      render :index #条件式が偽の場合は✖✖️️の処理をする。
    end
  end

  def index
    @book = Book.new #空のカラムを作成
    @books = Book.all # データ（レコード）を全件取得
    @user = current_user
  end

  def show
   # @book = Book.new #空のカラムを作成
    @books = Book.all # データ（レコード）を全件取得
    @book = Book.find(params[:id]) # データ（レコード）を1件取得
    @book_new = Book.new #空のカラムを作成
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id]) # データ（レコード）を1件取得
    if @book.user == current_user # データ（レコード）を更新 #条件文（条件式が可の場合は〇〇の処理を、偽の場合は✖✖の処理をする️
       render :edit #アクションを通さないパス #条件式が偽の場合は✖✖️️の処理をする
    else
       redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    if @book.update(book_params) # データ（レコード）を更新 #条件文（条件式が可の場合は〇〇の処理を、偽の場合は✖✖の処理をする️
      flash[:notice] = "You have updated book successfully." #Bookの更新が成功したときのフラッシュメッセージ
      redirect_to book_path(@book.id)  # 詳細一覧画面へリダイレクト #条件式が可の場合は〇〇の処理をする
    else
      render :edit #条件式が偽の場合は✖✖️️の処理をする
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path # 詳細一覧画面へリダイレクト
  end

   # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @user = @book.user #
    redirect_to (books_path) unless @user == current_user #
  end

end
