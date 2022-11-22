class Public::EndUsers::SessionsController < Devise::SessionsController
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to user_page_path(end_user), notice: 'guestuserでログインしました。'
  end
end