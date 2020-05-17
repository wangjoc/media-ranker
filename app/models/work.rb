class Work < ApplicationRecord
  has_many :votes
  has_many :users, :through => :votes

  validates :category, presence: true, inclusion: { 
    in: ["album", "book", "movie"],
    message: "not a valid category" }
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def order_works
    return Work.left_joins(:users).group(:id).order('COUNT(users) DESC')
  end

  def top_ten
    categories = {"album" => [], "book" => [], "movie" => []}
    ordered_works = order_works

    categories.each do |category, items|
      set = ordered_works.select {|work| work.category == category }
      categories[category] = set[0...[10, set.length].min]
    end

    return categories
  end
end
