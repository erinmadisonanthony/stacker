class Pic < ActiveRecord::Base
  validates :message, presence: true

  mount_uploader :photo, PhotoUploader

  belongs_to :user
end
