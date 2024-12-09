import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Function to upload image and return the download URL
  Future<String?> uploadImageAndGetURL(File imageFile) async {
    try {
      // Create a reference to the Firebase Storage location where you want to store the image
      String filePath = 'images/${DateTime.now().millisecondsSinceEpoch}.png'; // You can customize the path
      final ref = _storage.ref().child(filePath);

      // Upload the image to Firebase Storage
      final uploadTask = ref.putFile(imageFile);

      // Wait for the upload to complete
      await uploadTask;

      // Get the URL of the uploaded image
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Function to pick an image from the gallery (using image_picker)
  Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}