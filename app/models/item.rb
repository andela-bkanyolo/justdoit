class Item < ApplicationRecord
  extend Paginate

  validates :name, presence: true

  belongs_to :bucketlist
end
