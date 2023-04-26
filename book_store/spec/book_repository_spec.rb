require "books_repository"

def reset_books_table
  seed_sql = File.read('spec/seeds_books.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

RSpec.describe BooksRepository do
  before(:each) do 
    reset_books_table
  end

  it "returns both books" do
    repo = BooksRepository.new

    books = repo.all

    expect(books.length).to eq 2

    expect(books[0].id).to eq '1'
    expect(books[0].title).to eq 'La Belle Sauvage'
    expect(books[0].author_name).to eq 'Philip Pullman'

    expect(books[1].id).to eq '2'
    expect(books[1].title).to eq 'The Hobbit'
    expect(books[1].author_name).to eq 'J.R.R. Tolkien'
  end
end