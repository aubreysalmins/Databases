require "recipe_repository"

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  it "returns two recipes" do
    repo = RecipeRepository.new

    recipes = repo.all
    
    expect(recipes.length).to eq 2
    
    expect(recipes[0].id).to eq '1'
    expect(recipes[0].name).to eq 'Kimchi'
    expect(recipes[0].average_cooking_time).to eq '2 hrs'
    expect(recipes[0].rating).to eq '5'
    
    expect(recipes[1].id).to eq '2'
    expect(recipes[1].name).to eq 'Pasta w/ Meatballs and Tomato Sauce'
    expect(recipes[1].average_cooking_time).to eq '1 hour'
    expect(recipes[1].rating).to eq '5'
  end

  it "returns a single recipe" do
    repo = RecipeRepository.new

    recipe = repo.find(0)

    expect(recipe.id).to eq '1'
    expect(recipe.name).to eq 'Kimchi'
    expect(recipe.average_cooking_time).to eq '2 hrs'
    expect(recipe.rating).to eq '5'
  end
end