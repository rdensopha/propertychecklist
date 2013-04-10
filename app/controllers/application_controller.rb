class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    temp_user = User.where(id: session[:current_user_id]).first
    if  temp_user.present?
    @user =  temp_user
    else
     temp_user = User.new
     temp_user.add_role :guest
      @user = temp_user
    end
  end

  def user_logged_in?
    ! session[:current_user_id].nil?
  end

  def logged_in_user
    User.find session[:current_user_id]  if user_logged_in?
  end

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
