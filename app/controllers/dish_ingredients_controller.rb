class DishIngredientsController < ApplicationController
  def update
    @dish = Dish.find(params[:id])
    @ingredient = Ingredient.find(params[:dish][:id])
    @dish_ingredient = DishIngredient.create!(dish_id: @dish.id, ingredient_id: @ingredient.id)

    redirect_to dish_path(@dish)
  end
end