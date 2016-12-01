class Bucketlist < ApplicationRecord
  extend Paginate
  
  validates :name, presence: true

  belongs_to :user
end
