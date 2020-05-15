module PagesHelper
  def order_works
    return Work.left_joins(:users).group(:id).order('COUNT(users) DESC')
  end
end
