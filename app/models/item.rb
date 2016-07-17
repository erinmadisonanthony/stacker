class Item < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50, minimum: 2 }
  # validates :description, length: { maximum: 50, minimum: 2 }
end
