class Item < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50, minimum: 2 }

  belongs_to :user
end
