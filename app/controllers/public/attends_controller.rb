class Public::AttendsController < ApplicationController
  before_action :set_end_user, only: [:index]
  def index
    attends = Attend.where(end_user_id: @end_user.id).pluck(:schedule_id)
    @schedules = Schedule.find(attends)
  end
  
  def create
    schedule = Schedule.find(params[:schedule_id])
    attend = current_end_user.attends.new(schedule_id: schedule.id)
    attend.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    schedule = Schedule.find(params[:schedule_id])
    attend = current_end_user.attends.find_by(schedule_id: schedule.id)
    attend.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
    def set_end_user
      @end_user = EndUser.find(params[:id])
    end
end
