class Product {
  final String productName;
  final double price; // Assuming price is a decimal number
  final String sku;
  final String gtn;
  final double stock; // Assuming stock is measured in kg or pieces
  final String unitType; // "kg" or "pieces"
  final String description;
  final String productImage;
  final String category; // e.g., "Fruits & Vegetables", "Snacks"
  final String? businessID;

  Product(
      {required this.productName,
      required this.price,
      required this.sku,
      required this.gtn,
      required this.stock,
      required this.unitType,
      required this.description,
      required this.productImage,
      required this.category,
      required this.businessID});

  // Convert JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productName: json['productName'],
        price: json['price'].toDouble(), // Convert price to double
        sku: json['sku'],
        gtn: json['gtn'],
        stock: json['stock'].toDouble(), // Convert stock to double
        unitType: json['unitType'], // Either "kg" or "pieces"
        description:
            json['description'] ?? '', // Default to empty string if null
        productImage:
            json['productImage'] ?? '', // Default to empty string if null
        category: json['category'], // New field for product category
        businessID: json['businessID']);
  }

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'price': price,
      'sku': sku,
      'gtn': gtn,
      'stock': stock,
      'unitType': unitType,
      'description': description,
      'productImage': productImage,
      'category': category,
      'businessID' : businessID
    };
  }
}
