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
  has_many :accepted_friendships, -> { accepted }, class_name: 'Friendship'
  has_many :friends, through: :accepted_friendships

  def friend_requested?(user)
    false
  end
end
