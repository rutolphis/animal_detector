import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import '../api/api.dart';
import '../constants/animals.dart';
import 'imageDialog.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.max, // Use max resolution for full-screen
      );
      _controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      final image = await _controller!.takePicture();
      _showImageDialog(image.path);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _showImageDialog(image.path);
      }
    } catch (e) {
      print(e);
    }
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageDialog(imagePath: imagePath, );
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_controller!),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: _takePicture,
                  child: Icon(Icons.camera_alt),
                ),
                SizedBox(width: 20), // Spacing between buttons
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: _pickImageFromGallery,
                  child: Icon(Icons.photo_library),
                ),
              ],
            )),
      ],
    );
  }
}
