class Work < ApplicationRecord
  has_and_belongs_to_many :users

  validates :category, presence: true, inclusion: { 
    in: Work.all.map {|t| t.category}.uniq,
    message: "not a valid vategory" }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def order_works
    return Work.left_joins(:users).group(:id).order('COUNT(users) DESC')
  end

  # def category_list
  #   return works.all.map {|t| t.category}.uniq
  # end

  def self.all_categories
    Work.all.map {|t| t.category}.uniq
  end
end
