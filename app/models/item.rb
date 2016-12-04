class Item < ApplicationRecord
  extend Paginate
  extend Searchable

  validates :name, presence: true

  belongs_to :bucketlist
end
