import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Function to upload image and get the URL
  Future<String?> uploadImageAndGetURL(File imageFile) async {

    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      print("User is not authenticated");
    } else {
      print("User is authenticated: ${user.id}");
      // Proceed with the upload
      await uploadImageAndGetURL(imageFile);
    }


    try {
      // Reference to Supabase storage
      final storage = _supabaseClient.storage.from('my_bucket'); // Replace with your storage bucket name

      // Upload the file
      final response = await storage.upload('public/gg', imageFile);

      // Check if there is an error in the response
      print(response);

      // After successful upload, get the public URL
      final urlResponse = await storage.getPublicUrl('public/gg');
      print(urlResponse); // This is the public URL of the file

    } catch (e, stack) {
      print('Error uploading image: $e');
      print(stack);
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
