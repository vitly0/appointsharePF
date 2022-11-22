class Public::SchedulesController < ApplicationController
  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.end_user_id = current_end_user.id
    @schedule.save
    redirect_to schedule_path(@schedule.id)
  end

  def index
    @schedules = Schedule.all
  end

  def show
    @schedule = Schedule.find(params[:id])
    @schedule_comments = @schedule.schedule_comments
    @schedule_comment = current_end_user.schedule_comments.new
    @reports = @schedule.reports
    @report = current_end_user.reports.new
    @attends = @schedule.attends
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to schedule_path(@schedule), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to user_schedule_path(current_end_user)
  end

    
  
  private
  def schedule_params
    params.require(:schedule).permit(:title, :schedule_image, :body, :year, :month, :day, :location)
  end
end
