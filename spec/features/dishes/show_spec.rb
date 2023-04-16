require 'rails_helper'

RSpec.describe 'Dish Show Page', type: :feature do
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

  describe 'As a visitor, User Story 1' do
    it 'has a header' do
      visit dish_path(@dish_1)

      expect(page).to have_content("Dish Show Page")
    end

    it 'I see the dish nam and description' do
      visit dish_path(@dish_1)

      within "#dish-details" do
        expect(page).to have_content("Name: Ravioli")
        expect(page).to have_content("Description: Canned pasta")
      end

      visit dish_path(@dish_2)

      within "#dish-details" do
        expect(page).to have_content("Name: Spaghetti")
        expect(page).to have_content("Description: Pasta with red sauce")
      end
    end

    it 'I see a list of ingredients for that dish, it also shows calories' do
      visit dish_path(@dish_1)

      expect(page).to have_content("Ingredients:")
      within "#ingredients-#{@ingredient_1.id}" do
        expect(page).to have_content("Pasta")
        expect(page).to have_content("Calories: 100")
      end

      within "#ingredients-#{@ingredient_2.id}" do
        expect(page).to have_content("Tomato Sauce")
        expect(page).to have_content("Calories: 50")
      end
    end

    it 'I see a list of ingredients for another dish show page, as well as calories' do
      visit dish_path(@dish_2)

      expect(page).to have_content("Ingredients:")
      within "#ingredients-#{@ingredient_3.id}" do
        expect(page).to have_content("Cheese")
        expect(page).to have_content("Calories: 200")
      end

      within "#ingredients-#{@ingredient_4.id}" do
        expect(page).to have_content("Meat")
        expect(page).to have_content("Calories: 300")
      end
    end
    
    it 'I see the total calorie count for that dish' do
      visit dish_path(@dish_1)
      
      within "#dish-details" do
        expect(page).to have_content("Total Calories: 150")
      end
      
      visit dish_path(@dish_2)
      
      within "#dish-details" do
        expect(page).to have_content("Total Calories: 500")
      end
    end
    
    it 'I see the chef name' do
      visit dish_path(@dish_1)
      
      within "#dish-details" do
        expect(page).to have_content("Chef: Chef Boyardee")
      end
      
      visit dish_path(@dish_2)
      
      within "#dish-details" do
        expect(page).to have_content("Chef: Chef Ramsey")
      end
    end
  end

  describe 'As a visitor, User Story 2' do
    it 'I see a form to add an existing Ingredient to that Dish' do
      visit dish_path(@dish_1)

      within "#add-ingredient" do
        expect(page).to have_content("Add an Ingredient to this Dish:")
        expect(page).to have_field("Id")
      end
    end

    it 'when I fill it out and click submit, I am redirected to that dish show page, and I see that ingredient listed' do
      visit dish_path(@dish_1)

      within '#add-ingredient' do
        fill_in "Id", with: @ingredient_3.id
        click_button "Update Dish"
      end

      expect(current_path).to eq(dish_path(@dish_1))
      expect(page).to have_content("Cheese")
    end
  end
end

  