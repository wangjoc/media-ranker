module PagesHelper
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

  def top_vote
    return Work.left_joins(:users).group(:id).order('COUNT(users) DESC')[0]
  end
end
