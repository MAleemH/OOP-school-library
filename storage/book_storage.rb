class BookStorage
  def self.save(books)
    all_books = books.map { |book| { title: book.title, author: book.author } }
    File.write('./data/books.json', JSON.generate(all_books))
  end

  def self.books
    books = []
    if File.exist?('./data/books.json')
      JSON.parse(File.read('./data/books.json')).map do |book_hash|
        books.push(Book.new(book_hash['title'], book_hash['author']))
      end
    end
    books
  end
end
