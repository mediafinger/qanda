# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    Rails.logger.debug(ap(request.env["omniauth.auth"])) # TODO: remove

    user = User.find_or_create_from(request.env["omniauth.auth"]) # TODO: handle ActiveRecord::RecordInvalid
    session[:user_id] = user.id

    redirect_to root_path # TODO: redirect to last page
  end

  def destroy
    session.clear

    redirect_to root_path
  end
end
