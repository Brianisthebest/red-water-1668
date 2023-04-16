class DishIngredientsController < ApplicationController
  def update
    @dish = Dish.find(params[:id])
    @ingredient = Ingredient.find(params[:dish][:id])
    @dish_ingredient = DishIngredient.new(dish_id: @dish.id, ingredient_id: @ingredient.id)

    if @dish_ingredient.save
      redirect_to dish_path(@dish)
    else
      flash[:notice] = "Ingredient not added"
      redirect_to dish_path(@dish)
    end
  end
end