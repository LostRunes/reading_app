
class BookModel {
  final String title;
  final String author;
  final String assetPath;
  final String category;   
  final String categoryValue; 
  final int chapters;      
  final String description;
  final String pdfAssetPath;

  const BookModel({
    required this.title,
    required this.author,
    required this.assetPath,
    required this.category,
    required this.categoryValue,
    required this.chapters,
    required this.description,
    required this.pdfAssetPath,
  });
}
