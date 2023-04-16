require 'rails_helper'

RSpec.describe 'Ingredients Index Page', type: :feature do
  before(:each) do
    @chef_1 = Chef.create!(name: "Chef Boyardee")
    @chef_2 = Chef.create!(name: "Chef Ramsey")

    @dish_1 = @chef_1.dishes.create!(name: "Ravioli", description: "Canned pasta", chef_id: @chef_1.id)
    @dish_2 = @chef_2.dishes.create!(name: "Spaghetti", description: "Pasta with red sauce", chef_id: @chef_2.id)
    @dish_3 = @chef_1.dishes.create!(name: "Pizza", description: "Pizza, duh", chef_id: @chef_1.id)

    @ingredient_1 = Ingredient.create!(name: "Pasta", calories: 100)
    @ingredient_2 = Ingredient.create!(name: "Tomato Sauce", calories: 50)
    @ingredient_3 = Ingredient.create!(name: "Cheese", calories: 200)
    @ingredient_4 = Ingredient.create!(name: "Meat", calories: 300)

    @dish_ingredient_1 = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_1.id)
    @dish_ingredient_2 = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_2.id)
    @dish_ingredient_3 = DishIngredient.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_3.id)
    @dish_ingredient_4 = DishIngredient.create!(dish_id: @dish_3.id, ingredient_id: @ingredient_3.id)
  end

  describe 'As a visitor, User Story 3' do
    it 'lists all ingredients a chef uses' do
      visit chef_path(@chef_1)

      expect(page).to have_content("Most Popular Ingredients:")
      expect(page).to have_content("Pasta")
      expect(page).to have_content("Tomato Sauce")
      expect(page).to have_content("Cheese")
    end
  end
end