require_relative "./books"

class BooksRepository
  def all
    books = []
    sql = 'SELECT id, title, author_name FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |item|
      book = Book.new
      book.id = item['id']
      book.title = item['title']
      book.author_name = item['author_name']

      books << book
    end
    books
  end
end