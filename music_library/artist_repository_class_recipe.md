# Artists Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table
n/a

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (name, cohort_name) VALUES ('David', 'April 2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

# Table name: artists

# Model class
# (in lib/artist.rb)
class Album
end

# Repository class
# (in lib/artist_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Album

attr_accessor :id, :title, release_year, :artist_id
end

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: albums

# Repository class
# (in lib/artist_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
  end

  # Select a single record
  # Given the id in argument (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists WHERE id = $1

    # Returns a single Artist object
  end 

  # Insert a new artist record
  #Takes an Artist object in argument
  def create(artist)
    # Executes the SQL query:
    # INSERT INTO artists (name, genre) VALUES($1, $2);

    # Doesn't need to return anything (only creates the record)
  end

  # Deletes an artist record
  # given its id
  def delete(id)
    # Executes the SQL:
    # DELETE FROM artists WHERE id = $1;

    # Returns nothing (only deletes the record)
  end

  # Updates an artist record
  # Takes an Artist object (with the updated fields)
  def update(artist)
    # Executes the SQL:
    # UPDATE artists SET name = $1, genre = $2 WHERE id = $3

    # Returns nothing (only updates the record)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # => 2
albums.first.title # => 'Bossanova'
albums.first.release_year # => '1999'
albums.first.artist_id # => '1'

# 2
# Get a single artist

repo = ArtistRepository.new

artist = repo.find(1)

artist.name # => 'Pixies'
artist.genre # => 'Rock'

# 3 Create a new artist
repo = ArtistRepository.new

artist = Artist.new
artist.name = 'Beatles'
artist.genre = 'Pop'

repo.create(artist) # => nil

artists = repo.all

last_artist = artists.last
last_artist.name # => 'Beatles'
last_artist.genre # => 'Pop'

# 4
repo = ArtistRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_artists = repo.all
all_artists.length # => 1
all_artists.first.id # => '2'

# 5
repo = ArtistRepository.new

artist = repo.find(1)

artist.name = "Something else"
artist.genre = "Disco"

repo.update(artist)

updated_artist = repo.find(1)

updated_artist.name # => "Something else"
updated_artist.genre # => "Disco"



Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._