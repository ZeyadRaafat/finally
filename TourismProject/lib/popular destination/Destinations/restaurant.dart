class Rest {
  final String name;
  final List<String> imagePaths;
  final String description;
  final String url;
  final String locationurl;
  final String pdfPath;
  bool isFavorite;

  Rest(this.name, this.imagePaths, this.description, this.url, this.locationurl,
      this.isFavorite, this.pdfPath);
}
