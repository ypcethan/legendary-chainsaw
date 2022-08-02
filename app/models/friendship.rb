class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User", foreign_key: "friend_id"

  scope :accepted, -> { where.not(accepted_at: nil)}

  def accepted?
    !accepted_at.nil?
  end
end
