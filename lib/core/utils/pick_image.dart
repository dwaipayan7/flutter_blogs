import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<File?> pickImage() async {
  try {
    // Use FilePicker to pick an image file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Restrict to custom file types
      allowedExtensions: ['jpg', 'jpeg', 'png'], // Allowed extensions
    );

    // Check if a file was picked and handle its path
    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }

    // Return null if no file was picked
    return null;
  } catch (e) {
    // Log the error for debugging purposes
    print("Error picking file: $e");
    return null;
  }
}
