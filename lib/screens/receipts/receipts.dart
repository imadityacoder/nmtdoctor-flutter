import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ReceiptsContent extends StatefulWidget {
  const ReceiptsContent({super.key});

  @override
  State<ReceiptsContent> createState() => _ReceiptsContentState();
}

class _ReceiptsContentState extends State<ReceiptsContent> {
  File? _image; // Holds the selected/taken image
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to take a picture using the camera
  Future<void> _takePictureWithCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: nmtdAppbar(),
        bottomNavigationBar: const NmtdNavbar(),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the selected or captured image
              _image != null
                  ? Image.file(_image!,
                      width: 300, height: 300, fit: BoxFit.cover)
                  : const Text('No image selected'),
              const SizedBox(height: 20),
              // Buttons to pick or take an image
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: const Icon(Icons.photo),
                label: const Text('Pick Image from Gallery'),
              ),
              ElevatedButton.icon(
                onPressed: _takePictureWithCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Picture with Camera'),
              ),
            ],
          ),
        ),
      );
    }
  }
