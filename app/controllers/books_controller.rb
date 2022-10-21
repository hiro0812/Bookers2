class BooksController < ApplicationController
  def new
  end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id #current_userは、現在ログイン中のユーザーに関する情報を取得できる
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @book = Book.new #空のカラムを作成
    @books = Book.all # データ（レコード）を全件取得
  end

  def show
    @book_new = Book.new #空のカラムを作成
    @books = Book.all # データ（レコード）を全件取得
    @book = Book.find(params[:id]) # データ（レコード）を1件取得
  end

  def edit
    @book = Book.find(params[:id]) # データ（レコード）を1件取得
  end

  def update
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.update(book_params) # データ（レコード）を更新
    redirect_to books_path(book.id)  # 詳細一覧画面へリダイレク
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

end
