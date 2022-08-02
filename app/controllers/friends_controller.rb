class FriendsController < ApplicationController
  def create
    current_user.accept_request(request_issuer)

    redirect_back fallback_location: root_path
  end

  def destroy
    current_user.reject_request(request_issuer)

    redirect_back fallback_location: root_path
  end

  private

  def request_issuer
    User.find(params[:id] || params[:user_id])
  end
end
