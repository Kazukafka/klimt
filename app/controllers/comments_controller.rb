class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    if @comment.save
      #↓だとActiveControllerエラーが発生、参照するファイルも存在するが、一覧画面（Root）にリダイレクトすることで対応
      #respond_to :js
      redirect_to root_path
    else
      flash[:alert] = "コメントに失敗しました"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end

  private
    def comment_params
      params.required(:comment).permit(:user_id, :post_id, :comment)
    end
end
