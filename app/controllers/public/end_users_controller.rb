class Public::EndUsersController < ApplicationController
  def index
    @end_users = EndUser.all
  end
  
  def schedule_index
    @end_user = EndUser.find(params[:id])
    @schedules = @end_user.schedules
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

   def update
    @end_user = EndUser.find(current_end_user.id)
    if @end_user.update(end_user_params)
      redirect_to user_page_path(@end_user), notice: "You have updated user successfully."
    else
      render :edit
    end
   end
   
   def worked
    @end_user = EndUser.find(current_end_user.id)
    if @end_user.is_worked == true
      @end_user.is_worked = false
    else
      @end_user.is_worked = true
    end
    @end_user.update(worked_params)
    redirect_to user_page_path(@end_user), notice: "You have updated user successfully."
   end
  
  private

  def end_user_params
    params.require(:end_user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :department_name, :work_location, :telephone_number, :profile_image)
  end
  def worked_params
    params.permit(:is_worked)
  end
end