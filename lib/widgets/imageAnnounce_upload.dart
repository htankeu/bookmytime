import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAnnounceUpload extends StatefulWidget {
  const ImageAnnounceUpload({
    Key? key,
  }) : super(key: key);

  @override
  _ImageAnnounceUploadState createState() => _ImageAnnounceUploadState();
}

class _ImageAnnounceUploadState extends State<ImageAnnounceUpload> {
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: const Icon(
            Icons.camera_enhance,
          ),
        ),
        if (_selectedImage != null)
          ElevatedButton(
            onPressed: () {},
            child: const Icon(
              Icons.upload_rounded,
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (_selectedImage != null) {
        _selectedImage = File(_selectedImage!.path);
      } else {
        const Center(
          child: Text('No image selected'),
        );
      }
    });
  }
}
