class Public::ReportsController < ApplicationController
  def create
    @report = current_end_user.reports.new(report_params)
    if @report.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end
  
  def destroy
    @report = Report.find(params[:id])
    if @report.destroy
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end

  private
  def report_params
    params.require(:report).permit(:comment, :schedule_id, :end_user_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
