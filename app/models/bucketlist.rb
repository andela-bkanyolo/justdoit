class Bucketlist < ApplicationRecord
  extend Paginate

  validates :name, presence: true

  belongs_to :user

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
