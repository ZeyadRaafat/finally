class Hotel {
  final String name;
  final List<String> imagePaths;
  final String description;
  final int price;
  final String url;
  bool isFavorite;

  Hotel({
    required this.name,
    required this.imagePaths,
    required this.description,
    required this.price,
    required this.url,
    required this.isFavorite,
  });
}
