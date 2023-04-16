require 'rails_helper'

RSpec.describe Chef, type: :model do
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

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:ingredients).through(:dishes)}
  end

  describe "#instance methods" do
    describe "top_three_ingredients" do
      it 'returns the top three most popular ingredients for a chef' do
        expect(@chef_1.top_three_ingredients).to eq([@ingredient_1, @ingredient_2, @ingredient_4])
      end
    end
  end
end