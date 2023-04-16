require 'rails_helper'

 RSpec.describe 'Chef Show Page', type: :feature do
  before(:each) do
    @chef_1 = Chef.create!(name: "Chef Boyardee")
    @chef_2 = Chef.create!(name: "Chef Ramsey")

    @dish_1 = @chef_1.dishes.create!(name: "Ravioli", description: "Canned pasta", chef_id: @chef_1.id)
    @dish_2 = @chef_1.dishes.create!(name: "Pasta again", description: "Canned pasta", chef_id: @chef_1.id)
    @dish_3 = @chef_1.dishes.create!(name: "He loves noodles", description: "Canned pasta", chef_id: @chef_1.id)
    @dish_4 = @chef_1.dishes.create!(name: "Paste in top 3 for sure", description: "Canned pasta", chef_id: @chef_1.id)

    @ingredient_1 = Ingredient.create!(name: "Pasta", calories: 100)
    @ingredient_2 = Ingredient.create!(name: "Tomato Sauce", calories: 50)
    @ingredient_3 = Ingredient.create!(name: "Cheese", calories: 200)
    @ingredient_4 = Ingredient.create!(name: "Meat", calories: 300)
    @ingredient_5 = Ingredient.create!(name: "Banana", calories:75)
    @ingredient_6 = Ingredient.create!(name: "Apple", calories: 90)
    @ingredient_7 = Ingredient.create!(name: "Carrot", calories: 9000)

    @dish_ingredient_1 = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_1.id)
    @dish_ingredient_5 = DishIngredient.create!(dish_id: @dish_3.id, ingredient_id: @ingredient_1.id)
    @dish_ingredient_7 = DishIngredient.create!(dish_id: @dish_4.id, ingredient_id: @ingredient_1.id)
    @dish_ingredient_8 = DishIngredient.create!(dish_id: @dish_4.id, ingredient_id: @ingredient_1.id)
    @dish_ingredient_2 = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_2.id)
    @dish_ingredient_6 = DishIngredient.create!(dish_id: @dish_3.id, ingredient_id: @ingredient_2.id)
    @dish_ingredient_10 = DishIngredient.create!(dish_id: @dish_3.id, ingredient_id: @ingredient_2.id)
    @dish_ingredient_3 = DishIngredient.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_3.id)
    @dish_ingredient_4 = DishIngredient.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_4.id)
    @dish_ingredient_9 = DishIngredient.create!(dish_id: @dish_4.id, ingredient_id: @ingredient_4.id)
  end

  describe 'As a visitor, User Story 3' do
    it ' has a link to view a list of all ingredients that this chef uses in their dishes' do
      visit chef_path(@chef_1)

      expect(page).to have_link("Chef Ingredients")
    end

    it 'when I click the link takes me to a chef ingredients index page' do
      visit chef_path(@chef_1)

      click_link("Chef Ingredients")

      expect(current_path).to eq(chef_ingredients_path(@chef_1))
    end
  end

  describe 'As a visitor, Extension' do
    it 'lists the three most popular ingredients that the chef uses in their dishes' do
      visit chef_path(@chef_1)

      expect(page).to have_content("Most Popular Ingredients:")
      expect(page).to have_content("Pasta")
      expect(page).to have_content("Tomato Sauce")
      expect(page).to have_content("Meat")
    end
  end
 end