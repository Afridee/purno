import 'package:purnomerchant/models/user.dart';

class Business {
  final String uid; // Unique identifier for the business
  final String businessName;
  final String businessContactNumber;
  final String businessAddress;
  final String businessType;
  final String businessDescription;
  final String? businessLogo;
  final List<Person> people; // List of people (Person model) with their roles

  Business({
    required this.uid,
    required this.businessName,
    required this.businessContactNumber,
    required this.businessAddress,
    required this.businessType,
    required this.businessDescription,
    required this.businessLogo,
    required this.people,
  });

  // Convert JSON to Business object
  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      uid: json['uid'], // Extract uid from JSON
      businessName: json['businessName'],
      businessContactNumber: json['businessContactNumber'],
      businessAddress: json['businessAddress'],
      businessType: json['businessType'],
      businessDescription: json['businessDescription'],
      businessLogo: json['businessLogo'],
      people: (json['people'] as List)
          .map((personJson) => Person.fromJson(personJson))
          .toList(),
    );
  }

  // Convert Business object to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid, // Include uid in JSON
      'businessName': businessName,
      'businessContactNumber': businessContactNumber,
      'businessAddress': businessAddress,
      'businessType': businessType,
      'businessDescription': businessDescription,
      'businessLogo': businessLogo,
      'people': people.map((person) => person.toJson()).toList(),
    };
  }
}

class Person {
  final User user;
  final String role;

  Person({
    required this.user,
    required this.role,
  });

  // Convert JSON to Person object
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      user: User.fromJson(json['user']),
      role: json['role'],
    );
  }

  // Convert Person object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'role': role,
    };
  }
}

