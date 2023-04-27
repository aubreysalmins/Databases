

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  repo = RecipeRepository.new

  recipes = repo.all
  
  recipes.length # =>  2
  
  recipes[0].id # =>  1
  recipes[0].name # =>  'Kimchi'
  recipes[0].average_cooking time # =>  '2 hrs'
  recipes[0].rating # => 5
  
  recipes[1].id # =>  2
  recipes[1].name # =>  'Pasta w/ Meatballs and Tomato Sauce'
  recipes[1].average_cooking time # =>  '1 hour'
  recipes[1].rating # => 5
end