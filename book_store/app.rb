require_relative 'lib/database_connection'
require_relative 'lib/books_repository'

DatabaseConnection.connect('book_store')

book_repo = BooksRepository.new
result = book_repo.all

result.each do |record|
  p record.id + " - " + record.title + " - " + record.author_name
end