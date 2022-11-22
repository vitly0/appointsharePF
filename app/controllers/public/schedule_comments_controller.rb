class Public::ScheduleCommentsController < ApplicationController
  def create
    @schedule_comment = current_end_user.schedule_comments.new(schedule_comment_params)
    if @schedule_comment.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end
  
  def destroy
    @schedule_comment = ScheduleComment.find(params[:id])
    if @schedule_comment.destroy
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end

  private
  def schedule_comment_params
    params.require(:schedule_comment).permit(:comment, :schedule_id, :end_user_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
