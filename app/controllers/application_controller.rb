class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_password

  ### DEVISE OVERRIDES ###

  # # The path used after sign up
  def after_sign_up_path_for(resource)
    users_path
  end

  # # The path used after sign up for inactive accounts
  # def after_inactive_sign_up_path_for(resource)
  # end

  # # The path used after updating a resource
  def after_update_path_for(resource)
    users_path
  end

  # # The path used after sign_in
  def after_sign_in_path_for(resource)
    users_path
  end

  # # The path used after sign_out
  def after_sign_out_path_for(resource)
    users_path
  end

  ### END ###

  def check_password
    if user_signed_in?
      if current_user.has_no_password?
        flash[:notice] = 'Create a password to securely access your account.'
        redirect_to edit_password_users_path
      else
      end
    end
  end
end
