class BookStorage

  def self.save(books)
    all_books = books.map { |book| { title: book.title, author: book.author } }
    File.write('./data/books.json', JSON.generate(all_books))
  end

  def self.getBooks
    db_books = []
    if File.exist?('./data/books.json')
      JSON.parse(File.read('./data/books.json')).map do |book_hash|
        db_books.push(Book.new(book_hash['title'], book_hash['author']))
      end
    end
    db_books
  end

end
