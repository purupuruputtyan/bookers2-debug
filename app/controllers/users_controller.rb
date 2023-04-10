class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    #ここからDM機能
    @currentUserEntry = Entry.where(user_id: current_user.id)#ログインしているユーザーと
    @userEntry = Entry.where(user_id: @user.id)#メッセージ相手のユーザをEntryテーブルから検索して取得している
    unless @user.id == current_user.id#ログインしていないユーザーという条件をつける
      @currentUserEntry.each do |cu|#①
        @userEntry.each do |u|#②→①と②でさっき取得した２つのユーザーをそれぞれeachで取り出して
          if cu.room_id == u.room_id then#ログインユーザーと相手ユーザーのroom_idが一緒だったらという条件指定
            @isRoom = true#Entryテーブル内に同じroom_idが共通しているユーザー同士に対して
            @roomId = cu.room_id#@roomId=cu.room_idという変数を指定する
          end
        end
      end
      unless @isRoom#@isRoomがfalseの時
        @room = Room.new#新しくインスタンスを生成するために.newと記載
        @entry = Entry.new
      end
    end
    #投稿数カウント
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      @books = @user.books
      render "edit"
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
