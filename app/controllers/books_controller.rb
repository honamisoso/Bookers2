class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @books = Book.all
    @book = Book.new
  end
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    # 4. トップ画面へリダイレクト
    redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end
  def edit
     @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
    redirect_to books_path
    end
  end
end
