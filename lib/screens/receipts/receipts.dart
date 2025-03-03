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
      appBar: nmtdAppbar(
        title: const Text(
          'Upload Prescription',
        ),
      ),
      bottomNavigationBar: const NmtdNavbar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Display the selected or captured image
                  _image != null
                      ? Image.file(
                          _image!,
                          width: 300,
                          height: 400,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.black87,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.elliptical(6, 2),
                            ),
                            color: Colors.black12,
                          ),
                          alignment: Alignment.center,
                          width: 300,
                          height: 400,
                          child: const Text('Take/Select an Images'),
                        ),
                  const SizedBox(height: 20),
                  // Buttons to pick or take an image
                  _image != null
                      ? ElevatedButton.icon(
                          style: const ButtonStyle(
                            minimumSize: WidgetStatePropertyAll(Size(300, 42)),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.file_upload),
                          label: const Text('Submit'),
                        )
                      : Column(
                          children: [
                            ElevatedButton.icon(
                              style: const ButtonStyle(
                                minimumSize:
                                    WidgetStatePropertyAll(Size(300, 42)),
                              ),
                              onPressed: _pickImageFromGallery,
                              icon: const Icon(Icons.photo),
                              label: const Text('Pick Image from Gallery'),
                            ),
                            ElevatedButton.icon(
                              style: const ButtonStyle(
                                minimumSize:
                                    WidgetStatePropertyAll(Size(300, 42)),
                              ),
                              onPressed: _takePictureWithCamera,
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('Take Picture with Camera'),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
