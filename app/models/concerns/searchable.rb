module Searchable
  def search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
