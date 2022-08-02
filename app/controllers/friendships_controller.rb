class FriendshipsController < ApplicationController
  def create
    friend_id = params[:friend_id].to_i
    current_user.friendships.create!(friend_id: friend_id)

    redirect_to profiles_path
  end

  def destroy
    byebug
  end
end
