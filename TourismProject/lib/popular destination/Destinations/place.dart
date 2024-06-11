class Place {
  final String name;
  final List<String> imagePaths;
  final String description;
  final int price;
  final String url;
  final String locationurl;
  bool isFavorite;

  Place(this.name, this.imagePaths, this.description, this.price, this.url,
      this.locationurl, this.isFavorite);
}
