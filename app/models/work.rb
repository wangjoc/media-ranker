class Work < ApplicationRecord
  has_many :votes
  has_many :users, :through => :votes

  validates :category, presence: true, inclusion: { 
    in: Work.all.map {|t| t.category}.uniq,
    message: "not a valid vategory" }
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def order_works
    return Work.left_joins(:users).group(:id).order('COUNT(users) DESC')
  end
end
