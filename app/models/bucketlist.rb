class Bucketlist < ApplicationRecord
  extend Paginate
  extend Searchable

  validates :name, presence: true

  belongs_to :user
  has_many :items, dependent: :destroy
end
