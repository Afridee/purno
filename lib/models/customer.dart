class Customer {
  final String name;
  final String contactNumber;
  final String? email; // Optional email field
  final String customerType; // e.g., Regular, VIP, Wholesale
  final String businessID;

  Customer({
    required this.name,
    required this.contactNumber,
    this.email,
    required this.customerType,
    required this.businessID
  });

  // Convert JSON to Customer object
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      contactNumber: json['contactNumber'],
      email: json['email'], // This can be null
      customerType: json['customerType'],
      businessID: json['businessID']
    );
  }

  // Convert Customer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contactNumber': contactNumber,
      'email': email, // Can be null
      'customerType': customerType,
      'businessID' : businessID
    };
  }
}
