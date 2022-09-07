require 'recipe'
require 'recipe_repository'
require 'database_connection'

RSpec.describe RecipeRepository do

  # let(:repo) {RecipeRepository.new}

  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes_directory_test.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test', user: user, password: password })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_recipes_table
  end
  
  it 'returns all recipes' do
    repo = RecipeRepository.new
    recipes = repo.all
    expect(recipes.length).to eq 2
    expect(recipes[0].id).to eq "1"
    expect(recipes[0].name).to eq 'Burger'
    expect(recipes[0].cooking_time).to eq '30'
    expect(recipes[0].rating).to eq '5'
    expect(recipes[1].id).to eq "2"
    expect(recipes[1].name).to eq 'Salad'
    expect(recipes[1].cooking_time).to eq '2'
    expect(recipes[1].rating).to eq '1'
  end

  xit 'finds one recipe("Burger")' do
    recipe = repo.find(1)
    expect(recipe.id).to eq 1
    expect(recipe.name).to eq "Burger"
    expect(recipe.cooking_time).to eq "30"
    expect(recipe.rating).to eq "5"
  end

  xit 'finds one recipe ("Salad")' do
    recipe = repo.find(2)
    expect(recipe.id).to eq 2
    expect(recipe.name).to eq "Salad"
    expect(recipe.cooking_time).to eq "2"
    expect(recipe.rating).to eq "1"
  end  
end