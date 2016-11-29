class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\.]+[\w+]\.[a-z]+\z/i
end
