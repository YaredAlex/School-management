import 'package:get/get.dart';
import 'package:school_managment/features/library/model/books.dart';

class LibraryController extends GetxController {
  final RxList<Book> allBooks = <Book>[].obs;
  final RxMap<String, List<Book>> booksByCategory = <String, List<Book>>{}.obs;
  final RxList<String> categories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  void fetchBooks() {
    // Simulated API call to fetch books
    allBooks.value = [
      Book(
          id: '1',
          title: 'Introduction to Physics',
          author: 'John Doe',
          coverUrl:
              'https://m.media-amazon.com/images/I/61rBl9Dm3vL._AC_UF1000,1000_QL80_.jpg',
          category: 'Science'),
      Book(
          id: '2',
          title: 'Advanced Mathematics',
          author: 'Jane Smith',
          coverUrl:
              'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-030-17068-4',
          category: 'Mathematics'),
      Book(
          id: '3',
          title: 'World History',
          author: 'Alice Johnson',
          coverUrl:
              'https://m.media-amazon.com/images/I/71xG-raKGJL._AC_UF1000,1000_QL80_.jpg',
          category: 'Social Studies'),
      Book(
          id: '4',
          title: 'Organic Chemistry',
          author: 'Bob Williams',
          coverUrl:
              'https://rukminim2.flixcart.com/image/850/1000/kjlrb0w0-0/book/a/k/h/organic-chemistry-original-imafz587brdgjchy.jpeg?q=90&crop=false',
          category: 'Science'),
      Book(
          id: '5',
          title: 'Calculus I',
          author: 'Emma Brown',
          coverUrl:
              'https://m.media-amazon.com/images/I/61zN1OJXJaL._AC_UF1000,1000_QL80_.jpg',
          category: 'Mathematics'),
      Book(
          id: '6',
          title: 'Introduction to Psychology',
          author: 'David Lee',
          coverUrl:
              'https://i1.rgstatic.net/publication/338042312_Introduction_to_Psychology/links/5dfb7df74585159aa48889c2/largepreview.png',
          category: 'Social Studies'),
      Book(
          id: '7',
          title: 'Biology: The Study of Life',
          author: 'Sarah Miller',
          coverUrl:
              'https://m.media-amazon.com/images/I/51PXK26A02L._AC_UF1000,1000_QL80_.jpg',
          category: 'Science'),
      Book(
          id: '8',
          title: 'Linear Algebra',
          author: 'Michael Johnson',
          coverUrl: 'https://covers.openlibrary.org/b/id/8369252-L.jpg',
          category: 'Mathematics'),
      Book(
          id: '9',
          title: 'Introduction to Sociology',
          author: 'Emily Davis',
          coverUrl:
              'https://m.media-amazon.com/images/I/61Tvq8u1BsL._AC_UF1000,1000_QL80_.jpg',
          category: 'Social Studies'),
      Book(
          id: '10',
          title: 'Quantum Mechanics',
          author: 'Richard Feynman',
          coverUrl:
              'https://m.media-amazon.com/images/I/71b8cOIVY3L._AC_UF1000,1000_QL80_.jpg',
          category: 'Science'),
    ];

    _categorizeBooks();
  }

  void _categorizeBooks() {
    booksByCategory.clear();
    for (var book in allBooks) {
      if (!booksByCategory.containsKey(book.category)) {
        booksByCategory[book.category] = [];
      }
      booksByCategory[book.category]!.add(book);
    }
    categories.value = booksByCategory.keys.toList();
  }

  void filterBooks(String query) {
    if (query.isEmpty) {
      _categorizeBooks();
    } else {
      final lowercaseQuery = query.toLowerCase();
      booksByCategory.clear();
      for (var book in allBooks) {
        if (book.title.toLowerCase().contains(lowercaseQuery) ||
            book.author.toLowerCase().contains(lowercaseQuery) ||
            book.category.toLowerCase().contains(lowercaseQuery)) {
          if (!booksByCategory.containsKey(book.category)) {
            booksByCategory[book.category] = [];
          }
          booksByCategory[book.category]!.add(book);
        }
      }
      categories.value = booksByCategory.keys.toList();
    }
  }
}
