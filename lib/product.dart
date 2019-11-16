class Product {
  final String image;
  final String name;
  final int expirationDate;

  Product({this.image, this.name, this.expirationDate});

  @override
  String toString() {
    print("""
        PRODUCT:: name:$name, 
        image: $image,
        expirationDate: $expirationDate,
        """);
    return super.toString();
  }
}
