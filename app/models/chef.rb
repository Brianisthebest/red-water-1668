class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :ingredients, through: :dishes

  def top_three_ingredients
    ingredients.select('ingredients.*, count(ingredients.id) as ingredient_count').group(:id).order('ingredient_count desc').limit(3)
  end
end