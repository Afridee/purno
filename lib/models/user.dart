class User {
  final String fullName;
  final String contactNumber;
  final String emailAddress;
  final String profilePicture;

  User({
    required this.fullName,
    required this.contactNumber,
    required this.emailAddress,
    required this.profilePicture,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      contactNumber: json['contactNumber'],
      emailAddress: json['emailAddress'],
      profilePicture: json['profilePicture'] ?? '', // Default to empty string if null
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'contactNumber': contactNumber,
      'emailAddress': emailAddress,
      'profilePicture': profilePicture,
    };
  }
}
