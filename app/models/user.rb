# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: {case_sensitive: false}

  has_many :photos, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  has_many :friendships
  has_many :unaccepted_friendships, -> { unaccepted }, class_name: 'Friendship'
  has_many :accepted_friendships, -> { accepted }, class_name: 'Friendship'

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :unaccepted_inverse_friendships, -> { unaccepted } ,class_name: "Friendship", foreign_key: "friend_id"
  has_many :friendship_requests, through: :unaccepted_inverse_friendships, source: :user

  has_many :unaccepted_friends, through: :unaccepted_friendships
  has_many :friends, through: :accepted_friendships

  def friend_requested?(user)
    friendships.exists?(friend_id: user.id)
  end

  def send_frend_request(user)
    return if friend_requested?(user)

    friendships.create(friend_id: user.id)
  end

  def accept_request(user)
    return unless user.friend_requested?(self)

    inverse_friendships.find_by(user_id: user.id).update(accepted_at: Time.now)
    friendships.create(friend_id: user.id, accepted_at: Time.now)
  end

  def reject_request(user)
    return unless user.friend_requested?(self)

    inverse_friendships.find_by(user_id: user.id).destroy
  end
end
