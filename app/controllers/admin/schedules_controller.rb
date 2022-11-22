class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def show
    @schedule = Schedule.find(params[:id])
    @schedule_comments = @schedule.schedule_comments
    @reports = @schedule.reports
    @attends = @schedule.attends
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to admin_schedule_path(@schedule.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to admin_schedules_path
  end

  private
  def schedule_params
    params.require(:schedule).permit(:title, :schedule_image, :body, :year, :month, :day, :location)
  end
end
