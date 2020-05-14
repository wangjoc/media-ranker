class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  # def category_list
  #   return works.all.map {|t| t.category}.uniq
  # end
end
