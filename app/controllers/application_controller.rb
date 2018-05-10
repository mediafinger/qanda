# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authenticate
    redirect_to :login unless current_user.present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
