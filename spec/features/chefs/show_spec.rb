require 'rails_helper'
 RSpec.describe 'Chef Show Page', type: :feature do
  before(:each) do
    @chef_1 = Chef.create!(name: "Chef Boyardee")
    @chef_2 = Chef.create!(name: "Chef Ramsey")

    @dish_1 = @chef_1.dishes.create!(name: "Ravioli", description: "Canned pasta", chef_id: @chef_1.id)
    @dish_2 = @chef_2.dishes.create!(name: "Spaghetti", description: "Pasta with red sauce", chef_id: @chef_2.id)

    @ingredient_1 = Ingredient.create!(name: "Pasta", calories: 100)
    @ingredient_2 = Ingredient.create!(name: "Tomato Sauce", calories: 50)
    @ingredient_3 = Ingredient.create!(name: "Cheese", calories: 200)
    @ingredient_4 = Ingredient.create!(name: "Meat", calories: 300)

    @dish_ingredient_1 = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_1.id)
    @dish_ingredient_1 = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_2.id)
    @dish_ingredient_1 = DishIngredient.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_3.id)
    @dish_ingredient_1 = DishIngredient.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_4.id)
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

# When I visit a chef's show page
# I see a link to view a list of all ingredients that this chef uses in their dishes.
# When I click on that link
# I'm taken to a chef's ingredients index page
# and I can see a unique list of names of all the ingredients that this chef uses.
  end
 end