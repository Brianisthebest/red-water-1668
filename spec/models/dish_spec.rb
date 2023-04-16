require 'rails_helper'

RSpec.describe Dish, type: :model do
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

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "#instance methods" do
    describe "#total_calories" do
      it 'returns the total calories for a dish' do
        expect(@dish_1.total_calories).to eq(150)
        expect(@dish_2.total_calories).to eq(500)
      end
    end

    describe "#chef_name" do
      it 'returns the name of the chef for a dish' do
        expect(@dish_1.chef_name).to eq("Chef Boyardee")
        expect(@dish_2.chef_name).to eq("Chef Ramsey")
      end
    end
  end
end